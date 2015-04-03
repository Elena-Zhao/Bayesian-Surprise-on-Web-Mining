from sys import argv
import Markov

file_ = open(argv[1])
markov = Markov.Markov(file_)

fileCount = 0
while fileCount < argv[2]:
    randomText = markov.generate_markov_text(size = 1000)
    f = open(str(fileCount)+'.txt', 'w')
    print >> f, randomText
    f.close()
    fileCount += 1


