import urllib.request as urlreq
import re
import matplotlib.pyplot as plt
import math
from matplotlib.ticker import MaxNLocator

year_list = list()
co_author = list()

author = input("Input author: ")
print("[Author: "+ author + "]")
# author = "Aoki%2C+S" 
# author = "Ian Goodfellow"
query_author = author.replace(" ", "+")
query_author = query_author.replace(".", "%2C")
# print(query_author)
# print(author)

# First call to the author
url = "https://arxiv.org/search/?query=" + query_author + "&searchtype=author"
content = urlreq.urlopen(url)
html = content.read().decode("utf-8")

#  pattern for the entries
pattern_entry = "title is-clearfix[\s\S]*?Showing \d+&ndash;\d+ of \d+ results for author: <span class=\"mathjax\">"
result_entry = re.findall(pattern_entry, html)

# Getting how many entries papers does this author has
entries = int(re.findall("\d+", result_entry[0].split("of")[1])[0])

counter = 0

# pattern of getting each arxiv
arxiv_pattern = "arxiv-result[\s\S]*?</li>"
arxiv_list = re.findall(arxiv_pattern, html)

def processArxiv(arxivs, counter, year_list, co_author):
    for arxiv_html in arxivs:
        # authors 
        author_pattern = "<a href=\"/search/[\s\S]*?\">[\s\S]*?</a>"
        author_list = re.findall(author_pattern, arxiv_html)
        
        authors_in_list = []
        this_paper_has_the_author = False
        # print(author_list)
        for a in author_list:
            a = re.findall(">[\s\S]*?<", a)[0]
            a = a.split(">")[1].split("<")[0]
            if a != author:
                if a[0] == " ":
                    a = a.replace(" ", "")
                authors_in_list.append(a)
            elif a == author:
                this_paper_has_the_author = True

        if this_paper_has_the_author is True:
            counter = counter + 1
            co_author.extend(authors_in_list)
            # year
            year_pattern ="originally announced</span>[\s\S]*?</p>"
            year_html = re.findall(year_pattern, arxiv_html)[0]
            year = int(re.findall("\d+", year_html)[0])
            year_list.append(year)
            
    return counter, year_list, co_author

counter, year_list, co_author = processArxiv(arxiv_list, counter, year_list, co_author)

# exit()
# if the entries > 50, we have to query for the next page or next..... page
if entries > 50:
    start = 0

    # do it once and we donw
    pages = math.ceil(entries / 50)

    for i in range(pages - 1):

        # do it the rest of your live
        url = "https://arxiv.org/search/?query=" + query_author + "&searchtype=author&size=50&start=" + str(50 * (i+1))
        content = urlreq.urlopen(url)
        html = content.read().decode("utf-8")

        # pattern of getting each arxiv
        arxiv_pattern = "arxiv-result[\s\S]*?</li>"
        arxiv_list = re.findall(arxiv_pattern, html)

        counter, year_list, co_author = processArxiv(arxiv_list, counter, year_list, co_author)

co_author_dict = {}
for i in co_author:
    if i not in co_author_dict:
        co_author_dict[i] = 0
    co_author_dict[i] += 1

sortedCoauthor = sorted(co_author_dict.keys())

for i in sortedCoauthor:
    print("{:<25s}: {:d} times".format(i, co_author_dict[i]))

result_year = {}
for i in year_list:
    if i not in result_year:
        result_year[i] = 0
    result_year[i] += 1
ax = plt.figure().gca()
plt.bar(result_year.keys(),result_year.values())
ax.xaxis.set_major_locator(MaxNLocator(integer=True))
ax.yaxis.set_major_locator(MaxNLocator(integer=True))
plt.xlabel('Year of Announcement')
plt.ylabel('Number of Papers')
plt.show()

print("Only have %d papers for author %s"%(counter,author))