
from requests import get
from requests.exceptions import RequestException
from contextlib import closing
from bs4 import BeautifulSoup
import nltk
from nltk.corpus import stopwords
import json
import os
import ast

"""
*************************************
Scraper
*************************************
"""
def fetchFromURL(url):
    try:
        with closing(get(url, stream=True)) as resp:
            if is_good_response(resp):
                return resp.content
            else:
                return None

    except RequestException as e:
        log_error('Error during request to {0}:{1}' . format(url, str(e)))

        return None

def is_good_response(resp):
    content_type = resp.headers['Content-Type'].lower()

    return (resp.status_code == 200
            and content_type is not None
            and content_type.find('html') > -1)

def log_error(e):
    print(e)

def get_target_urls(target):
    soup = BeautifulSoup(target,'html.parser')
    for row in soup.find_all('td'):
        for link in row.find_all('a'):
            print(link.get('href'))
"""
******************************
End of Scraper
****************************
"""


#Only used for the plays: gets the title from the subSoup
def getTitle(soup):
    count = 0
    index = 0
    title = soup.title.string
    for char in title:
        if char == ':':
            index = title.index(char)
            break
    title = title[:index]
    return title

#Creates a Termindex given a file, title, in-progress tokenDict, stopWordList
#    and creates a normalized term list to create bigrams
def createTermIndex(stopWordList, tokenDict,title,fileName,normalizedWordList):
    #gets the text
    textFile = open(fileName,'r')
    title = removeBadCharacters(title)
    text = textFile.read()
    wordList = text.split()
    for word in wordList:
        #lowercase all the letters
        word = word.lower()
        #delete all special characters (leaving only a-z)
        index = 0
        for letter in word:
            if (ord(letter) <= 96) or (ord(letter) >= 123):
                word = word[:index] + word[index+1:]
                index = index -1
            index += 1
        if not(word in stopWordList):
            
            #tokenDict = {term: [Frequency, playID1, playID2, playID3,...]
            #Frequency = tokenDict[term][0] because it is first item in list
            if word in tokenDict:
                #Add one to frequency
                tokenDict[word][0] += 1
                #Add docID if first time for a specific play
                if not(title in tokenDict[word]):
                    tokenDict[word].append(title)
            #Add first occurence of term in dictionary 
            else:
                tokenDict[word] = [1,title]
                normalizedWordList.append(word)
               
def createBigramIndex(normalizedWordList):
    bigramDict = {}
    for word in normalizedWordList:
        cashMoney = '$'+word+'$'
        startIndex = 0
        endIndex = 2
        while endIndex <= len(cashMoney):
            bigram = cashMoney[startIndex:endIndex]
            startIndex += 1
            endIndex += 1
            if bigram in bigramDict:
                if not(word in bigramDict[bigram]):
                    bigramDict[bigram].append(word)
            else:
                bigramDict[bigram] = [word]
    return bigramDict

def outputDictionary(dictionary,title):
    dictString = json.dumps(dictionary)
    outputFile = open(title,'w')
    outputFile.write(dictString)
    outputFile.close()
            
#Given Document Collection, creates termIndex(invertedIndex) and bigramIndex
def evaluateDocuments():
    stopWordFile = open('stopWords.txt','r')
    stopWordText = stopWordFile.read()
    stopWordList = stopWordText.split()
    stopWordList.append("")
    tokenDict = {}
    fileList = []
    normalizedWordList = []
    #excludes these if you run the program with these files already in there
    excludeDocumentsList = ['stopWords.txt','termIndex.txt','bigramIndex.txt']

    #for file in folder of program...
    for file in os.listdir("."):
        fileExtension = file[len(file)-3:]
        #if the object is a file with a .txt extension...
        if (os.path.isfile(file) == True) and (fileExtension == 'txt') and\
           (not (file in excludeDocumentsList)):
            #adds textFile to list
            fileList.append(file)

    #for each file in the list of files
    for fileName in fileList:
        #removes extension to have the name for docIDs
        title = fileName[:len(fileName)-4]
        #createsTermIndex
        createTermIndex(stopWordList,tokenDict, title,fileName,normalizedWordList)  
    #creates bigramIndex from normalized terms gathered when creating termIndex
    bigramDict = createBigramIndex(normalizedWordList)
    #Writes the dictionaries/Indexes to text files
    outputDictionary(tokenDict,'termIndex.txt')
    outputDictionary(bigramDict,'bigramIndex.txt')
    return stopWordList
    
    
        
        
# Made a .txt file for each play, sonnet, poem
def createDocumentCollection():
    mainPageLinks = []
    orginPage = 'http://shakespeare.mit.edu'
    raw_html = fetchFromURL(orginPage)
    soup = BeautifulSoup(raw_html,'html.parser')
    #ignores initial links
    for tableData in soup.find_all("tr"):
        for aTag in tableData.find_all("a"):
            link = aTag.get('href')
            #ignores last links
            if '.html' in link:
                mainPageLinks.append(link)
                
    #Goes through all the links except the poems
    for link in mainPageLinks:
        if mainPageLinks.index(link) <= len(mainPageLinks) - 6:
            link = orginPage+"/"+link
            sub_raw_html = fetchFromURL(link)
            subSoup = BeautifulSoup(sub_raw_html, 'html.parser')
            title = getTitle(subSoup)
            for aTag in subSoup.find_all("a"):
                if 'Entire play' in aTag:
                    textLink = aTag.get('href')
                    textLink = link.replace('index.html',textLink)
                    text_raw_html = fetchFromURL(textLink)
                    textSoup = BeautifulSoup(text_raw_html, 'html.parser')
                    text = textSoup.get_text()
                    outputFile = open(title+'.txt','w')
                    outputFile.write(text)
                    outputFile.close()
                    break
    #Goes through the sonnet links
    linkToSonnets = mainPageLinks[len(mainPageLinks)-5]
    linkToSonnets = orginPage + "/" + linkToSonnets
    sonnets_raw_html = fetchFromURL(linkToSonnets)
    sonnetsSoup = BeautifulSoup(sonnets_raw_html, 'html.parser')
    sonnetList = sonnetsSoup.dl
    count = 1
    for aTag in sonnetList.find_all("a"):
        sonnetLink = aTag.get('href')
        sonnetLink = linkToSonnets.replace('sonnets.html',sonnetLink)
        sonnet_raw_html = fetchFromURL(sonnetLink)
        sonnetSoup = BeautifulSoup(sonnet_raw_html,'html.parser')
        sonnetText = sonnetSoup.get_text()
        title = 'Sonnet'+ str(count)
        outputFile = open(title+'.txt',"w")
        outputFile.write(sonnetText)
        outputFile.close()
        count += 1
    #Goes through the rest of the poems
    poemsList = mainPageLinks[len(mainPageLinks)-4:]
    counter = 0
    for poemLink in poemsList:
        link = orginPage + "/" + poemLink
        poemText_raw_html = fetchFromURL(link)
        poemTextSoup = BeautifulSoup(poemText_raw_html,'html.parser')
        poemText = poemTextSoup.get_text()
        title = poemTextSoup.title.string
        title = title[1:len(title)-1]
        outputFile = open(title+'.txt',"w")
        outputFile.write(poemText)
        outputFile.close()
def userInputValidation(userQueryInput):
    userQueryInput = userQueryInput.lower()
    index = 0
    for character in userQueryInput:
        if ((ord(character) <= 96) or (ord(character) >= 123)):
            userQueryInput = userQueryInput[:index] + userQueryInput[index+1:]
            index = index - 1
        index += 1
    return userQueryInput

def query(stopWordList):
    #opens, reads, closes bigramIndex file and termIndex file
    invertedIndexFile = open("termIndex.txt","r")
    invertedIndexText = invertedIndexFile.read()
    invertedIndexFile.close()
    bigramIndexFile = open("bigramIndex.txt","r")
    bigramIndexText = bigramIndexFile.read()
    bigramIndexFile.close()
    #gets user input
    userQueryInput = str(input("\n\nEnter query term: "))
    #validates user input
    userQueryInput = userInputValidation(userQueryInput)
    #quits function is userInput = q or Q
    if userQueryInput == 'q':
        return userQueryInput
    #since i used .txt files, transform filestring, which is in dictionary format, into an...
    #actual dictionary
    invertedIndexDict = ast.literal_eval(invertedIndexText)
    bigramIndexDict = ast.literal_eval(bigramIndexText)
    try:
        #if word exists, retrieves posting list of the word from the invertedIndex
        postingList = invertedIndexDict[userQueryInput]
        #ignores the first term in posting list, which was the term frequency
        postingList = postingList[1:]
        #if the posting list is more than 50, word is too common
        if len(postingList) >= 50:
            print("\nThe term '"+userQueryInput+"' is too common. Please choose another word.")
        else:
            #alphabetizes posting list, and prints it
            postingList.sort()
            print("\nThe term '"+userQueryInput+"' was found in the following plays:")
            for play in postingList:
                print(play)
    except:#if word doesnt exist in inverted index...
        #if it is a stop word, informs user that it is too vague
        if userQueryInput in stopWordList:
            print("\nThe term '"+userQueryInput+"' is too vague. Please choose another word.")
        else:#see if there are any similar words - spell correction
            exceptionFunction(userQueryInput, bigramIndexDict)
    return userQueryInput

def exceptionFunction(userQueryInput, bigramIndexDict):
        suggestedTermList = []
        #makes bigrams of query word
        queryBigramList = createBigramList(userQueryInput)
        for bigram in queryBigramList:
            #runs the jaccard coefficint function for each bigram in query word
            newSuggestedTermList = jaccardCoefficient(queryBigramList, bigram, bigramIndexDict)
            for term in newSuggestedTermList:
                #adds unique terms that were found with the jaccard coefficient
                if not(term in suggestedTermList):
                    suggestedTermList.append(term)
        #if some were found, prints them
        if len(suggestedTermList) > 0:
            print("\nThe term '"+userQueryInput+"' was not found.")
            print("The following terms are similar and found within the plays")
            for suggestedTerm in suggestedTermList:
                print(suggestedTerm)
        else:
            print("\nThe term '"+userQueryInput+"' was not found.")


                
def jaccardCoefficient(queryBigramList, bigram, bigramIndexDict):
    try:
        #uses the bigramIndex to find all the words with the one of the bigrams from the query
        queryBigramTermList = bigramIndexDict[bigram]
    except:
        #if the bigram doesnt exist in the index, returns an empty list
        return []
    suggestedTermList = []
    #for each term with the query bigram...
    for term in queryBigramTermList:
        #makes a list of bigrams of the term
        termBigramList = createBigramList(term)
        #retrieves the union and intersection of the two bigram lists
        union,intersection = compareBigramLists(termBigramList, queryBigramList)
        jaccardCoefficient = intersection / union
        #adds the term if the coefficient is equal to or higher than .5
        if jaccardCoefficient >= .5:
            suggestedTermList.append(term)
    return suggestedTermList
        

def compareBigramLists(termBigramList, queryBigramList):
    unionBigramList = []
    intersectionBigramList = []
    for bigram in queryBigramList:
        #if query bigram is in the termBigramList, add it to both the union and intersection lists
        if bigram in termBigramList:
            if not(bigram in intersectionBigramList):
                intersectionBigramList.append(bigram)
            if not(bigram in unionBigramList):
                unionBigramList.append(bigram)
            #removes the bigram from the termBigramList
            termBigramList.remove(bigram)
        else:
            #adds bigram to only union list, if that bigram isn't already in there
            if not(bigram in unionBigramList):
                unionBigramList.append(bigram)
    #since we removed the common bigrams from the termBigramList, we add the rest of the ones
    #to the union list if the bigram doesnt already exist in it.
    for bigram in termBigramList:
        if not(bigram in unionBigramList):
            unionBigramList.append(bigram)
    #returns the lengths of each list, since we dont need the actual bigrams.
    return len(unionBigramList), len(intersectionBigramList)


            

#makes a list of bigrams from a single word    
def createBigramList(word):
    bigramList = []
    cashMoney = "$"+word+"$"
    startIndex = 0
    endIndex = 2
    while endIndex <= len(cashMoney):
        bigram = cashMoney[startIndex:endIndex]
        startIndex += 1
        endIndex += 1
        if not(bigram in bigramList):
            bigramList.append(bigram)
    return bigramList
    
    
        
        

#used this to remove "\n" characters that were causing problems
def removeBadCharacters(playName):
    if ord(playName[0]) == 10:
        playName = playName[1:]
    if ord(playName[-1]) == 10:
        playName = playName[:-1]
    return playName

    
def main():
    createDocumentCollection()
    stopWordList = evaluateDocuments()

    print("\n\nPlease enter a single word. Sparky will list all the plays that the word was found in.")
    print("Numbers, special characters, and spaces will be removed from the query.")
    print("Type: 'Q' or 'q' to stop the program.")
    loop = True
    while loop:
        userQueryInput = query(stopWordList)
        if userQueryInput == 'q':
            loop = False
    print("Thank you for choosing StealthyTiger Programming. Have a wonderful day. :) ")

main()          

            

