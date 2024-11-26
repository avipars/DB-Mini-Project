import random
import json
from faker import Faker

# Initialize Faker for random realistic data
faker = Faker()


BOOK_SCRIPT = 'INSERT INTO Book (BookID, Title, ISBNID, PublisherID, Pages, Format, GenreID, LanguageID, Description, AuthorsID, LocationID, ReleaseDate) VALUES'
LOCATION_SCRIPT = 'INSERT INTO Location (LocationID, Shelf, Floor, Quantity, Condition) VALUES'
AUTHOR_SCRIPT = 'INSERT INTO Author (AuthorID, Firstname, Lastname, Bio, DOB) VALUES'
PUBLISHER_SCRIPT = 'INSERT INTO Publisher (PublisherID, Name, CountryID, Phone, Website) VALUES'
COUNTRY_SCRIPT = 'INSERT INTO Country (CountryID, Name) VALUES'
GENRE_SCRIPT = 'INSERT INTO Genre (GenreID, Name) VALUES'
LANGUAGE_SCRIPT = 'INSERT INTO Language (LanguageID, Name) VALUES'


def generate_number(count):
    num = ""
    for i in range(count):
        num += str(random.randint(0, 9))
    return num

# generate random address
# def generate_address():
#     return f"{random.randint(1, 9999)} {r.random_words(1)} {r.random_words(1)}"
# # generate random url
# def generate_url():
#     return f"https://{r.random_words(1)}.com"

NUM_BOOKS = 10
NUM_AUTHORS = 5
NUM_PUBLISHERS = 3
NUM_LOCATIONS = 10

# List of random data
COUNTRIES_LIST = ["USA", "Canada", "Mexico", "Brazil", "Argentina", "Chile", "UK", "Germany", "France", "Italy", "Spain", "Russia", "China", "Japan", "India", "Australia", "South Africa", "Nigeria", "Egypt", "Saudi Arabia", "Iran", "South Korea", "North Korea", "Uzbekistan"]
GENRES_LIST = ['Accounting', 'Anthropology', 'Art', 'Autobiography', 'Biography', 'Biology', 'Business', 'Chemistry', "Children's", 'Comics', 'Computer Science', 'Consulting', 'Cooking', 'Criminal Justice', 'Customer Service', 'Dance', 'Dentistry', 'Drama', 'Economics', 'Education', 'Engineering', 'Entrepreneurship', 'Fantasy', 'Fiction', 'Film', 'Finance', 'Fitness', 'Geography', 'Graphic Novel', 'Health', 'History', 'Horror', 'Human Resources', 'Information Technology', 'Innovation', 'Journalism', 'Law', 'Leadership', 'Literature', 'Logistics', 'Management', 'Marketing', 'Mathematics', 'Medicine', 'Music', 'Mystery', 'Non-Fiction', 'Nursing', 'Operations', 'Pharmacy', 'Philosophy', 'Physics', 'Poetry', 'Political Science', 'Politics', 'Psychiatry', 'Psychology', 'Radio', 'Religion', 'Romance', 'Sales', 'Science', 'Science Fiction', 'Self-Help', 'Sociology', 'Spirituality', 'Sports', 'Strategy', 'Supply Chain', 'Technology', 'Television', 'Theatre', 'Theology', 'Thriller', 'Travel', 'Veterinary', 'Young Adult']
LANGUAGE_LIST = ["English", "Spanish", "French", "German", "Italian", "Portuguese", "Dutch", "Russian","Amharic","Aramaic", "Chinese", "Japanese", "Korean", "Arabic", "Hindi", "Bengali", "Urdu", "Punjabi", "Telugu", "Marathi", "Tamil", "Gujarati", "Kannada", "Odia", "Malayalam", "Sindhi", "Sanskrit", "Persian", "Turkish", "Greek", "Swedish", "Norwegian", "Danish", "Finnish", "Icelandic", "Polish", "Czech", "Slovak", "Hungarian", "Romanian", "Bulgarian", "Serbian", "Croatian", "Bosnian", "Slovenian", "Macedonian", "Albanian", "Greek", "Armenian", "Georgian", "Azerbaijani", "Kazakh", "Uzbek", "Turkmen", "Kyrgyz", "Tajik", "Pashto", "Balochi", "Kurdish", "Arabic", "Hebrew", "Yiddish"]
CONDITION_LIST = ["New", "Like New", "Very Good", "Good", "Acceptable", "Poor", "Damaged", "Worn", "Torn", "Stained", "Faded", "Yellowed", "Aged", "Moldy", "Musty", "Dusty", "Dirty", "Scratched", "Cracked", "Chipped", "Broken", "Missing", "Incomplete", "Defective", "Faulty", "Expired", "Outdated", "Obsolete", "Discontinued", "Rare", "Limited Edition", "First Edition", "Signed", "Autographed", "Dedicated", "Inscribed", "Personalized", "Gifted", "Donated", "Borrowed", "Stolen", "Lost", "Found", "Recovered", "Returned", "Sold", "Purchased", "Bought", "Traded", "Exchanged", "Given", "Received", "Acquired", "Owned", "Possessed", "Kept", "Stored", "Displayed", "Showcased", "Presented", "Gifted", "Donated", "Lent", "Borrowed", "Returned", "Lost", "Found", "Stolen", "Recovered", "Sold", "Purchased", "Bought", "Traded", "Exchanged", "Given", "Received", "Acquired", "Owned", "Possessed", "Kept", "Stored", "Displayed", "Showcased", "Presented", "Gifted", "Donated", "Lent", "Borrowed", "Returned", "Lost", "Found", "Stolen", "Recovered", "Sold", "Purchased", "Bought", "Traded", "Exchanged", "Given", "Received", "Acquired", "Owned", "Possessed", "Kept", "Stored", "Displayed", "Showcased", "Presented", "Gifted", "Donated", "Lent", "Borrowed", "Returned", "Lost", "Found", "Stolen", "Recovered", "Sold", "Purchased", "Bought", "Traded", "Exchanged", "Given", "Received", "Acquired", "Owned", "Possessed", "Kept", "Stored", "Displayed", "Showcased", "Presented", "Gifted", "Donated", "Lent"]
BOOKFORMAT_LIST = ["Hardcover", "Paperback", "Ebook", "Audiobook", "Large Print", "Pocket", "Mass Market", "Trade", "Library", "Reference", "Textbook", "Workbook", "Guide", "Manual", "Handbook", "Dictionary", "Encyclopedia", "Atlas", "Almanac", "Yearbook", "Journal", "Magazine", "Newspaper", "Newsletter", "Brochure", "Pamphlet", "Leaflet", "Flyer", "Poster", "Postcard", "Bookmark", "Calendar", "Planner", "Diary", "Journal", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook"]
FLOOR = ["Archive", "Storage", "Returns", "Kids Corner", "Young Adult Section", "Adult Section", "Reference Section", "Study Area", "Computer Lab", "History Section"]

BOOKS = {
    "BookID": [],
    "Title": [],
    "ISBNID": [],
    "PublisherID": [],
    "Pages": [],
    "Format": [],
    "GenreID": [],
    "LanguageID": [],
    "Description": [],
    "AuthorsID": [],
    "LocationID": [],
    "ReleaseDate": []
}
AUTHORS = {
    "AuthorID": [],
    "Firstname": [],
    "Lastname": [],
    "Bio": [],
    "DOB": []
}
PUBLISHERS = {
    "PublisherID": [],
    "Name": [],
    "CountryID": [],
    "Phone": [],
    "Website": []
}
LOCATIONS = {
    "LocationID": [],
    "Shelf": [],
    "Floor": [],
    "Quantity": [],
    "Condition": []
}
LANGUAGES = {
    "LanguageID": [],
    "LanguageName": []
}
COUNTRIES = {
    "CountryID": [],
    "CountryName": []
}
GENRES = {
    "GenreID": [],
    "GenreName": [],
    "Description": []
}

# Generate random data
def generate_data(num_books=NUM_BOOKS, num_authors=NUM_AUTHORS, num_publishers=NUM_PUBLISHERS, num_locations=NUM_LOCATIONS):
    
    # generate countries
    for i in range(len(COUNTRIES_LIST)):
        COUNTRIES["CountryID"].append(i)
        COUNTRIES["CountryName"].append(COUNTRIES_LIST[i])

    # Generate publishers
    for _ in range(num_publishers):
        PUBLISHERS["PublisherID"].append(faker.random_number(digits=5))
        PUBLISHERS["Name"].append(faker.company())
        PUBLISHERS["CountryID"].append(random.choice(COUNTRIES["CountryID"]))
        PUBLISHERS["Phone"].append(faker.phone_number())
        PUBLISHERS["Website"].append(faker.url())

    # generate genres
    for i in range(len(GENRES_LIST)):
        GENRES["GenreID"].append(i)
        GENRES["GenreName"].append(GENRES_LIST[i])
        GENRES["Description"].append(faker.sentence())

    # generate languages
    for i in range(len(LANGUAGE_LIST)):
        LANGUAGES["LanguageID"].append(i)
        LANGUAGES["LanguageName"].append(LANGUAGE_LIST[i])
    # Generate authors
    for _ in range(num_authors):
        AUTHORS["AuthorID"].append(faker.random_number(digits=9))
        AUTHORS["Firstname"].append(faker.first_name())
        AUTHORS["Lastname"].append(faker.last_name())
        AUTHORS["Bio"].append(faker.paragraph())
        AUTHORS["DOB"].append(f"{random.randint(1900, 2021)}/{random.randint(1, 12)}/{random.randint(1, 28)}")

    # generate locations
    for i in range(num_locations):
        LOCATIONS["LocationID"].append(i)
        LOCATIONS["Shelf"].append(faker.random_number(digits=2))
        LOCATIONS["Floor"].append(random.choice(FLOOR))
        LOCATIONS["Quantity"].append(faker.random_number(digits=2))
        LOCATIONS["Condition"].append(random.choice(CONDITION_LIST))

    # Generate books
    for _ in range(num_books):
        BOOKS["BookID"].append(faker.random_number(digits=5))
        BOOKS["Title"].append(faker.sentence())
        BOOKS["PublisherID"].append(random.choice(PUBLISHERS["PublisherID"]))
        BOOKS["ISBNID"].append(faker.random_number(digits=13))
        BOOKS["Pages"].append(faker.random_number(digits=3))
        BOOKS["Format"].append(random.choice(BOOKFORMAT_LIST))
        BOOKS["GenreID"].append(random.choice(GENRES["GenreID"]))
        BOOKS["LanguageID"].append(random.choice(LANGUAGES["LanguageID"]))
        BOOKS["Description"].append(faker.paragraph())
        BOOKS["AuthorsID"].append(random.choice(AUTHORS["AuthorID"]))
        BOOKS["LocationID"].append(random.choice(LOCATIONS["LocationID"]))
        BOOKS["ReleaseDate"].append(faker.date())


# Save data to a JSON file
def save_to_json_file():
    with open("random_data.json", "w") as file:
        file.write("{")
        for i in range(NUM_BOOKS):
            book = {
                "BookID": BOOKS["BookID"][i],
                "Title": BOOKS["Title"][i],
                "ISBNID": BOOKS["ISBNID"][i],
                "PublisherID": BOOKS["PublisherID"][i],
                "Pages": BOOKS["Pages"][i],
                "Format": BOOKS["Format"][i],
                "GenreID": BOOKS["GenreID"][i],
                "LanguageID": BOOKS["LanguageID"][i],
                "Description": BOOKS["Description"][i],
                "AuthorsID": BOOKS["AuthorsID"][i],
                "LocationID": BOOKS["LocationID"][i],
                "ReleaseDate": BOOKS["ReleaseDate"][i]
            }
            file.write(f"\"Book #{i+1}\": {json.dumps(book)},")
            file.write("\n")

        for i in range(NUM_AUTHORS):
            author = {
                "AuthorID": AUTHORS["AuthorID"][i],
                "Firstname": AUTHORS["Firstname"][i],
                "Lastname": AUTHORS["Lastname"][i],
                "Bio": AUTHORS["Bio"][i],
                "DOB": AUTHORS["DOB"][i]
            }
            file.write(f"\"Author #{i+1}\": {json.dumps(author)},")
            file.write("\n")

        for i in range(NUM_PUBLISHERS):
            publisher = {
                "PublisherID": PUBLISHERS["PublisherID"][i],
                "Name": PUBLISHERS["Name"][i],
                "CountryID": PUBLISHERS["CountryID"][i],
                "Phone": PUBLISHERS["Phone"][i],
                "Website": PUBLISHERS["Website"][i]
            }
            file.write(f"\"Publisher #{i+1}\": {json.dumps(publisher)},")
            file.write("\n")
            
        for i in range(NUM_LOCATIONS):
            location = {
                "LocationID": LOCATIONS["LocationID"][i],
                "Shelf": LOCATIONS["Shelf"][i],
                "Floor": LOCATIONS["Floor"][i],
                "Quantity": LOCATIONS["Quantity"][i],
                "Condition": LOCATIONS["Condition"][i]
            }
            file.write(f"\"Location #{i+1}\": {json.dumps(location)},")
            file.write("\n")

        for i in range(len(COUNTRIES_LIST)):
            country = {
                "CountryID": COUNTRIES["CountryID"][i],
                "CountryName": COUNTRIES["CountryName"][i]
            }
            file.write(f"\"Country #{i+1}\": {json.dumps(country)},")
            file.write("\n")

        for i in range(len(GENRES_LIST)):
            genre = {
                "GenreID": GENRES["GenreID"][i],
                "GenreName": GENRES["GenreName"][i],
                "Description": GENRES["Description"][i]
            }
            file.write(f"\"Genre #{i+1}\": {json.dumps(genre)},")
            file.write("\n")

        for i in range(len(LANGUAGE_LIST)):
            language = {
                "LanguageID": LANGUAGES["LanguageID"][i],
                "LanguageName": LANGUAGES["LanguageName"][i]
            }
            file.write(f"\"Language #{i+1}\": {json.dumps(language)},")
            file.write("\n")


        file.write(f"\"TotalBooks\":" + str(NUM_BOOKS) + ",\n")
        file.write(f"\"TotalAuthors\":" + str(NUM_AUTHORS) + ",\n")
        file.write(f"\"TotalPublishers:\":" + str(NUM_PUBLISHERS) + ",\n")
        file.write(f"\"TotalLocations:\":" + str(NUM_LOCATIONS) + "\n")
        file.write("}")


# Save each data into a PostgreSQL script
def save_to_sql_script():
    with open("random_data.sql", "w") as file:
        file.write(BOOK_SCRIPT)
        for i in range(NUM_BOOKS):
            file.write(f"({BOOKS['BookID'][i]}, '{BOOKS['Title'][i]}', {BOOKS['ISBNID'][i]}, {BOOKS['PublisherID'][i]}, {BOOKS['Pages'][i]}, '{BOOKS['Format'][i]}', {BOOKS['GenreID'][i]}, {BOOKS['LanguageID'][i]}, '{BOOKS['Description'][i]}', {BOOKS['AuthorsID'][i]}, {BOOKS['LocationID'][i]}, '{BOOKS['ReleaseDate'][i]}')")
            if i != NUM_BOOKS - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

        file.write(LOCATION_SCRIPT)
        for i in range(NUM_LOCATIONS):
            file.write(f"({LOCATIONS['LocationID'][i]}, '{LOCATIONS['Shelf'][i]}', '{LOCATIONS['Floor'][i]}', {LOCATIONS['Quantity'][i]}, '{LOCATIONS['Condition'][i]}')")
            if i != NUM_LOCATIONS - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

        file.write(AUTHOR_SCRIPT)
        for i in range(NUM_AUTHORS):
            file.write(f"({AUTHORS['AuthorID'][i]}, '{AUTHORS['Firstname'][i]}', '{AUTHORS['Lastname'][i]}', '{AUTHORS['Bio'][i]}', '{AUTHORS['DOB'][i]}')")
            if i != NUM_AUTHORS - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

        file.write(PUBLISHER_SCRIPT)
        for i in range(NUM_PUBLISHERS):
            file.write(f"({PUBLISHERS['PublisherID'][i]}, '{PUBLISHERS['Name'][i]}', {PUBLISHERS['CountryID'][i]}, '{PUBLISHERS['Phone'][i]}', '{PUBLISHERS['Website'][i]}')")
            if i != NUM_PUBLISHERS - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

        file.write(COUNTRY_SCRIPT)
        for i in range(len(COUNTRIES_LIST)):
            file.write(f"({COUNTRIES['CountryID'][i]}, '{COUNTRIES['CountryName'][i]}')")
            if i != len(COUNTRIES_LIST) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

        file.write(GENRE_SCRIPT)
        for i in range(len(GENRES_LIST)):
            file.write(f"({GENRES['GenreID'][i]}, '{GENRES['GenreName'][i]}')")
            if i != len(GENRES_LIST) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

        file.write(LANGUAGE_SCRIPT)
        for i in range(len(LANGUAGE_LIST)):
            file.write(f"({LANGUAGES['LanguageID'][i]}, '{LANGUAGES['LanguageName'][i]}')")
            if i != len(LANGUAGE_LIST) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")






# Main function to generate and save data
def main():
    generate_data()
    save_to_json_file()
    save_to_sql_script()

if __name__ == "__main__":
    main()
