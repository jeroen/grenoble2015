json <- '{
  "topic" :  "jsonlite and mongolite",
  "talks" : [
    {
      "date" : "2015-06-25",
      "location" : "Grenoble"
    },{
      "date" : "2015-07-01",
      "location" : "Aalborg"
    }
  ],
  "speaker" : {
    "name" : "Jeroen Ooms",
    "age" : 30,
    "affiliation" : "UCLA",
    "francophone" : false
  },
  "slides" : "http://bit.ly/json2015"
}'

talks <- jsonlite::fromJSON(json)
print(info$topic)

print(info$speaker$affiliation)
