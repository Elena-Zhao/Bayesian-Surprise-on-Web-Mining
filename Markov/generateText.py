from sys import argv
from random import Random
import Markov

file_ = open(argv[1])
markov = Markov.Markov(file_)

def random_str(randomlength=8):
    str = ''
    chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789'
    length = len(chars) - 1
    random = Random()
    for i in range(randomlength):
        str+=chars[random.randint(0, length)]
    return str

fileCount = 0
while fileCount < argv[2]:
    randomText = markov.generate_markov_text(size = 1000)
    f = open(random_str(6)+'-R.txt', 'w')
    print >> f, randomText
    f.close()
    fileCount += 1



