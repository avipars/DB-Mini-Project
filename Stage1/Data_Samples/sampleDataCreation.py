import random
import json
from faker import Faker
import os
from datetime import datetime

# Initialize Faker for random realistic data
faker = Faker("en_US")

# SQL Statements
BOOK_SCRIPT = 'INSERT INTO Book (Title, ID, Release_Date, Page_Count, Format, Description, ISBN) VALUES'
LOCATION_SCRIPT = 'INSERT INTO Location (Quantity, Floor, Shelf, Location_ID, Condition, ID) VALUES'
AUTHOR_SCRIPT = 'INSERT INTO Author (First_Name, Last_Name, Date_of_Birth, Author_ID, Biography) VALUES'
PUBLISHER_SCRIPT = 'INSERT INTO Publisher (Name, Phone_Number, Website, Publisher_ID) VALUES'
COUNTRY_SCRIPT = 'INSERT INTO Country (Name, Country_ID) VALUES'
GENRE_SCRIPT = 'INSERT INTO Genre (Name, Description, Genre_ID) VALUES'
LANGUAGE_SCRIPT = 'INSERT INTO Language (Language_ID, Name) VALUES'

WRITTEN_BY_SCRIPT = 'INSERT INTO Written_By (ID, Author_ID) VALUES'
PUBLISHED_BY_SCRIPT = 'INSERT INTO Published_By (ID, Publisher_ID) VALUES'
WRITTEN_IN_SCRIPT = 'INSERT INTO Written_In (ID, Language_ID) VALUES'
TYPE_OF_SCRIPT = 'INSERT INTO Type_of (ID, Genre_ID) VALUES'
IS_IN_SCRIPT = 'INSERT INTO Is_In (Publisher_ID, Country_ID) VALUES'

# give a count digit number (as a string)
def generate_number(count):
    num = ""
    for i in range(count):
        num += str(random.randint(0, 9))
    return num

# Generate unique random numbers
def generate_unique_id(existing_ids, digits=9):
    new_id = faker.random_number(digits=digits)
    while new_id in existing_ids:
        new_id = faker.random_number(digits=digits)
    existing_ids.add(new_id)
    return new_id

# generate date between two values
def generate_date(start ="1800-01-01", end = "2006-01-01"):
    if isinstance(start, str):
        start = datetime.strptime(start, "%Y-%m-%d").date()
    if isinstance(end, str):
        end = datetime.strptime(end, "%Y-%m-%d").date()
    return faker.date_between(start_date=start, end_date=end)

NUM_BOOKS = 100000
NUM_AUTHORS = 5000
NUM_PUBLISHERS = 30000
NUM_LOCATIONS = 70000

# List of random data
COUNTRIES_LIST = ["USA", "Canada", "Mexico", "Brazil", "Argentina", "Chile", "UK", "Germany", "France", "Italy", "Spain", "Russia", "China", "Japan", "India", "Australia", "South Africa", "Nigeria", "Egypt", "Saudi Arabia", "Iran", "South Korea", "North Korea", "Uzbekistan"]
GENRES_LIST = ['Accounting', 'Anthropology', 'Art', 'Autobiography', 'Biography', 'Biology', 'Business', 'Chemistry', "Childrens", 'Comics', 'Computer Science', 'Consulting', 'Cooking', 'Criminal Justice', 'Customer Service', 'Dance', 'Dentistry', 'Drama', 'Economics', 'Education', 'Engineering', 'Entrepreneurship', 'Fantasy', 'Fiction', 'Film', 'Finance', 'Fitness', 'Geography', 'Graphic Novel', 'Health', 'History', 'Horror', 'Human Resources', 'Information Technology', 'Innovation', 'Journalism', 'Law', 'Leadership', 'Literature', 'Logistics', 'Management', 'Marketing', 'Mathematics', 'Medicine', 'Music', 'Mystery', 'Non-Fiction', 'Nursing', 'Operations', 'Pharmacy', 'Philosophy', 'Physics', 'Poetry', 'Political Science', 'Politics', 'Psychiatry', 'Psychology', 'Radio', 'Religion', 'Romance', 'Sales', 'Science', 'Science Fiction', 'Self-Help', 'Sociology', 'Spirituality', 'Sports', 'Strategy', 'Supply Chain', 'Technology', 'Television', 'Theatre', 'Theology', 'Thriller', 'Travel', 'Veterinary', 'Young Adult']
LANGUAGE_LIST = ["English", "Spanish", "French", "German", "Italian", "Portuguese", "Dutch", "Russian","Amharic","Aramaic", "Chinese", "Japanese", "Korean", "Arabic", "Hindi", "Bengali", "Urdu", "Punjabi", "Telugu", "Marathi", "Tamil", "Gujarati", "Kannada", "Odia", "Malayalam", "Sindhi", "Sanskrit", "Persian", "Turkish", "Greek", "Swedish", "Norwegian", "Danish", "Finnish", "Icelandic", "Polish", "Czech", "Slovak", "Hungarian", "Romanian", "Bulgarian", "Serbian", "Croatian", "Bosnian", "Slovenian", "Macedonian", "Albanian", "Greek", "Armenian", "Georgian", "Azerbaijani", "Kazakh", "Uzbek", "Turkmen", "Kyrgyz", "Tajik", "Pashto", "Balochi", "Kurdish", "Arabic", "Hebrew", "Yiddish"]
CONDITION_LIST = ["New", "Like New", "Very Good", "Good", "Acceptable", "Poor", "Damaged", "Worn", "Torn", "Stained", "Faded", "Yellowed", "Aged", "Moldy", "Dusty", "Dirty", "Scratched", "Cracked", "Chipped", "Broken", "Missing", "Incomplete", "Defective", "Faulty", "Expired", "Outdated", "Obsolete", "Discontinued", "Rare", "Limited Edition", "First Edition", "Signed", "Autographed", "Dedicated", "Inscribed", "Personalized", "Gifted", "Donated", "Borrowed", "Stolen", "Lost", "Found", "Recovered", "Returned", "Sold", "Purchased", "Bought", "Traded", "Exchanged", "Given", "Received", "Acquired", "Owned", "Possessed", "Kept", "Stored", "Displayed", "Showcased", "Presented", "Gifted", "Donated", "Lent", "Borrowed", "Returned", "Lost", "Found", "Stolen", "Recovered", "Sold", "Purchased", "Bought", "Traded", "Exchanged", "Given", "Received", "Acquired", "Owned", "Possessed", "Kept", "Stored", "Displayed", "Showcased", "Presented", "Gifted", "Donated", "Lent", "Borrowed", "Returned", "Lost", "Found", "Stolen", "Recovered", "Sold", "Purchased", "Bought", "Traded", "Exchanged", "Given", "Received", "Acquired", "Owned", "Possessed", "Kept", "Stored", "Displayed", "Showcased", "Presented", "Gifted", "Donated", "Lent", "Borrowed", "Returned", "Lost", "Found", "Stolen", "Recovered", "Sold", "Purchased", "Bought", "Traded", "Exchanged", "Given", "Received", "Acquired", "Owned", "Possessed", "Kept", "Stored", "Displayed", "Showcased", "Presented", "Gifted", "Donated", "Lent"]
BOOKFORMAT_LIST = ["Hardcover", "Paperback", "Ebook", "Audiobook", "Large Print", "Pocket", "Mass Market", "Trade", "Library", "Reference", "Textbook", "Workbook", "Guide", "Manual", "Handbook", "Dictionary", "Encyclopedia", "Atlas", "Almanac", "Yearbook", "Journal", "Magazine", "Newspaper", "Newsletter", "Brochure", "Pamphlet", "Leaflet", "Flyer", "Poster", "Postcard", "Bookmark", "Calendar", "Planner", "Diary", "Journal", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook"]
FLOOR = ["Archive", "Storage", "Returns", "Kids Corner", "Young Adult Section", "Adult Section", "Reference Section", "Study Area", "Computer Lab", "History Section"]

BOOKS = {
    "ID": [], # book id
    "Title": [],
    "ISBN": [],
    "Publisher_ID": [],
    "Page_Count": [],
    "Format": [],
    "Genre_ID": [],
    "Language_ID": [],
    "Description": [],
    "Author_ID": [],
    "Location_ID": [],
    "Release_Date": []
}

COUNTRIES = {
    "Country_ID": [],
    "Name": []
}

AUTHORS = {
    "Author_ID": [],
    "First_Name": [],
    "Last_Name": [],
    "Date_of_Birth": [],
    "Biography": []
}
PUBLISHERS = {
    "Publisher_ID": [],
    "Name": [],
    "Phone_Number": [],
    "Website": []
}
LOCATIONS = {
    "Location_ID": [],
    "Quantity": [],
    "Floor": [],
    "Shelf": [],
    "Condition": [],
    "ID": []  # Foreign key to Book(ID)
}

LANGUAGES = {
    "Language_ID": [],
    "Name": []
}

GENRES = {
    "Genre_ID": [],
    "Name": [],
    "Description": []
}

WRITTEN_BY = {
    "ID": [],          # Foreign key to Book(ID)
    "Author_ID": []    # Foreign key to Author(Author_ID)
}

PUBLISHED_BY = {
    "ID": [],           # Foreign key to Book(ID)
    "Publisher_ID": []  # Foreign key to Publisher(Publisher_ID)
}

WRITTEN_IN = {
    "ID": [],          # Foreign key to Book(ID)
    "Language_ID": []  # Foreign key to Language(Language_ID)
}

TYPE_OF = {
    "ID": [],         # Foreign key to Book(ID)
    "Genre_ID": []    # Foreign key to Genre(Genre_ID)
}

IS_IN = {
    "Publisher_ID": [],  # Foreign key to Publisher(Publisher_ID)
    "Country_ID": []     # Foreign key to Country(Country_ID)
}

# Generate random data
def generate_data(num_books=NUM_BOOKS, num_authors=NUM_AUTHORS, num_publishers=NUM_PUBLISHERS, num_locations=NUM_LOCATIONS):
    print(f"Generating {num_books} books, {num_authors} authors, {num_publishers} publishers, and {num_locations} locations...")
    # generate countries
    for i in range(len(COUNTRIES_LIST)):
        COUNTRIES["Country_ID"].append(i) # sequential country id
        COUNTRIES["Name"].append(COUNTRIES_LIST[i])

    # Generate publishers
    unique_publisher_ids = set()
    for _ in range(num_publishers):       
        PUBLISHERS["Publisher_ID"].append(generate_unique_id(unique_publisher_ids, digits=5)) # ensure unique
        PUBLISHERS["Name"].append(faker.company())
        PUBLISHERS["Phone_Number"].append(faker.phone_number())
        PUBLISHERS["Website"].append(faker.url())

    # generate genres
    for i in range(len(GENRES_LIST)):
        GENRES["Genre_ID"].append(i) 
        GENRES["Name"].append(GENRES_LIST[i])
        GENRES["Description"].append(faker.sentence())

    # generate languages
    for i in range(len(LANGUAGE_LIST)):
        LANGUAGES["Language_ID"].append(i)
        LANGUAGES["Name"].append(LANGUAGE_LIST[i])

    unique_author_ids = set()
    # Generate authors
    for _ in range(num_authors):
        AUTHORS["Author_ID"].append(generate_unique_id(unique_author_ids, digits=9))
        AUTHORS["First_Name"].append(faker.first_name())
        AUTHORS["Last_Name"].append(faker.last_name())
        AUTHORS["Biography"].append(faker.paragraph())
        AUTHORS["Date_of_Birth"].append(generate_date())

    unique_book_ids = set()
    unique_isbn = set()
    # Generate books
    for i in range(num_books):
        BOOKS["ID"].append(generate_unique_id(unique_book_ids, digits=5))
        BOOKS["Title"].append(faker.sentence())
        BOOKS["ISBN"].append(generate_unique_id(unique_isbn, digits=9)) # original isbn standard
        BOOKS["Page_Count"].append(faker.random_number(digits=3))
        BOOKS["Format"].append(random.choice(BOOKFORMAT_LIST))
        BOOKS["Description"].append(faker.paragraph())
        BOOKS["Release_Date"].append(generate_date(start="1850-01-01", end=datetime.now().strftime("%Y-%m-%d")))

    # generate locations
    for i in range(num_locations):
        LOCATIONS["Location_ID"].append(i)
        LOCATIONS["Shelf"].append(faker.random_number(digits=2))
        LOCATIONS["Floor"].append(random.choice(FLOOR))
        LOCATIONS["Quantity"].append(faker.random_number(digits=2))
        LOCATIONS["Condition"].append(random.choice(CONDITION_LIST))
        LOCATIONS["ID"].append(BOOKS["ID"][random.randint(0, num_books - 1)])

    # generate relations for written_by
    for book_index in range(num_books):
        already_written_list = []
        for author_amount in range(1, random.randint(1, 5)): # 1 to 5 authors for one book
            author_index = random.randint(0, num_authors - 1) # random author
            if AUTHORS["Date_of_Birth"][author_index] < BOOKS["Release_Date"][book_index] and AUTHORS["Author_ID"][author_index] not in already_written_list: # author must be born before the book is released and not already added
                WRITTEN_BY["ID"].append(BOOKS["ID"][book_index])
                WRITTEN_BY["Author_ID"].append(AUTHORS["Author_ID"][author_index])
                already_written_list.append(AUTHORS["Author_ID"][author_index])
        if WRITTEN_BY["ID"] == []: # if no author is found, add a random author
            while True:
                author_index = random.randint(0, num_authors - 1)
                if AUTHORS["Date_of_Birth"][author_index] < BOOKS["Release_Date"][book_index]: # author must be born before the book is released
                    WRITTEN_BY["ID"].append(BOOKS["ID"][book_index])
                    WRITTEN_BY["Author_ID"].append(AUTHORS["Author_ID"][author_index])
                    break # break the loop if a valid author is found

    # generate relations for published_by
    for i in range(num_books):
        already_published_list = []
        publisher_index = random.randint(0, num_publishers - 1) # random publisher
        PUBLISHED_BY["ID"].append(BOOKS["ID"][i])
        PUBLISHED_BY["Publisher_ID"].append(PUBLISHERS["Publisher_ID"][publisher_index])
        already_published_list.append(PUBLISHERS["Publisher_ID"][publisher_index])
        fake = faker.boolean(chance_of_getting_true=20) # 20% chance of having multiple publishers
        while fake:
            publisher_index = random.randint(0, num_publishers - 1)
            if PUBLISHERS["Publisher_ID"][publisher_index] not in already_published_list:
                PUBLISHED_BY["ID"].append(BOOKS["ID"][i])
                PUBLISHED_BY["Publisher_ID"].append(PUBLISHERS["Publisher_ID"][publisher_index])
                already_published_list.append(PUBLISHERS["Publisher_ID"][publisher_index])
                fake = faker.boolean(chance_of_getting_true=20) # 20% chance of having multiple publishers


    # generate relations for written_in
    for i in range(num_books):
        already_written_in_list = []
        language_index = random.randint(0, len(LANGUAGE_LIST) - 1)
        WRITTEN_IN["ID"].append(BOOKS["ID"][i])
        WRITTEN_IN["Language_ID"].append(LANGUAGES["Language_ID"][language_index])
        already_written_in_list.append(LANGUAGES["Language_ID"][language_index])
        fake = faker.boolean(chance_of_getting_true=20) # 20% chance of having multiple languages
        while fake:
            language_index = random.randint(0, len(LANGUAGE_LIST) - 1)
            if LANGUAGES["Language_ID"][language_index] not in already_written_in_list:
                WRITTEN_IN["ID"].append(BOOKS["ID"][i])
                WRITTEN_IN["Language_ID"].append(LANGUAGES["Language_ID"][language_index])
                already_written_in_list.append(LANGUAGES["Language_ID"][language_index])
                fake = faker.boolean(chance_of_getting_true=20) # 20% chance of having multiple languages


    # generate relations for type_of
    for i in range(num_books):
        already_type_of_list = []
        genre_index = random.randint(0, len(GENRES_LIST) - 1)
        TYPE_OF["ID"].append(BOOKS["ID"][i])
        TYPE_OF["Genre_ID"].append(GENRES["Genre_ID"][genre_index])
        already_type_of_list.append(GENRES["Genre_ID"][genre_index])
        fake = faker.boolean(chance_of_getting_true=20) # 20% chance of having multiple genres
        while fake:
            genre_index = random.randint(0, len(GENRES_LIST) - 1)
            if GENRES["Genre_ID"][genre_index] not in already_type_of_list:
                TYPE_OF["ID"].append(BOOKS["ID"][i])
                TYPE_OF["Genre_ID"].append(GENRES["Genre_ID"][genre_index])
                already_type_of_list.append(GENRES["Genre_ID"][genre_index])
                fake = faker.boolean(chance_of_getting_true=20) # 20% chance of having multiple genres

    # generate relations for is_in
    unique_pairs = set()  # To keep track of unique (Publisher_ID, Country_ID) pairs
    for i in range(num_publishers):
        publisher_id = PUBLISHERS["Publisher_ID"][i]
        country_id = random.randint(0, len(COUNTRIES_LIST) - 1)
        already_is_in_list = []
        
        # Add the first country
        IS_IN["Publisher_ID"].append(publisher_id)
        IS_IN["Country_ID"].append(COUNTRIES["Country_ID"][country_id])
        already_is_in_list.append(COUNTRIES["Country_ID"][country_id])
        unique_pairs.add((publisher_id, COUNTRIES["Country_ID"][country_id]))
        
        # Check for additional countries with a 20% chance
        fake = faker.boolean(chance_of_getting_true=20)
        while fake:
            country_index = random.randint(0, len(COUNTRIES_LIST) - 1)
            new_country_id = COUNTRIES["Country_ID"][country_index]
            
            # Ensure no duplicate entries
            if new_country_id not in already_is_in_list and (publisher_id, new_country_id) not in unique_pairs:
                IS_IN["Publisher_ID"].append(publisher_id)
                IS_IN["Country_ID"].append(new_country_id)
                already_is_in_list.append(new_country_id)
                unique_pairs.add((publisher_id, new_country_id))
            
            # Roll for another country
            fake = faker.boolean(chance_of_getting_true=20)


# Save data to a JSON file
# def save_to_json_file():
#     with open("./Data Samples/random_data.json", "w") as file:
#         file.write("{")
#         for i in range(NUM_BOOKS):
#             book = {
#                 "ID": BOOKS["ID"][i],
#                 "Title": BOOKS["Title"][i],
#                 "ISBN": BOOKS["ISBN"][i],
#                 "Page_Count": BOOKS["Page_Count"][i],
#                 "Format": BOOKS["Format"][i],
#                 "Description": BOOKS["Description"][i],
#                 "Release_Date": BOOKS["Release_Date"][i]
#             }
#             file.write(f"\"Book #{i+1}\": {json.dumps(book)},")
#             file.write("\n")

#         for i in range(NUM_AUTHORS):
#             author = {
#                 "Author_ID": AUTHORS["Author_ID"][i],
#                 "First_Name": AUTHORS["First_Name"][i],
#                 "Last_Name": AUTHORS["Last_Name"][i],
#                 "Biography": AUTHORS["Biography"][i],
#                 "Date_of_Birth": AUTHORS["Date_of_Birth"][i]
#             }
#             file.write(f"\"Author #{i+1}\": {json.dumps(author)},")
#             file.write("\n")

#         for i in range(NUM_PUBLISHERS):
#             publisher = {
#                 "Publisher_ID": PUBLISHERS["Publisher_ID"][i],
#                 "Name": PUBLISHERS["Name"][i],
#                 "Country_ID": PUBLISHERS["Country_ID"][i],
#                 "Phone": PUBLISHERS["Phone"][i],
#                 "Website": PUBLISHERS["Website"][i]
#             }
#             file.write(f"\"Publisher #{i+1}\": {json.dumps(publisher)},")
#             file.write("\n")
            
#         for i in range(NUM_LOCATIONS):
#             location = {
#                 "Location_ID": LOCATIONS["Location_ID"][i],
#                 "Shelf": LOCATIONS["Shelf"][i],
#                 "Floor": LOCATIONS["Floor"][i],
#                 "Quantity": LOCATIONS["Quantity"][i],
#                 "Condition": LOCATIONS["Condition"][i]
#             }
#             file.write(f"\"Location #{i+1}\": {json.dumps(location)},")
#             file.write("\n")

#         for i in range(len(COUNTRIES_LIST)):
#             country = {
#                 "Country_ID": COUNTRIES["Country_ID"][i],
#                 "Name": COUNTRIES["Name"][i]
#             }
#             file.write(f"\"Country #{i+1}\": {json.dumps(country)},")
#             file.write("\n")

#         for i in range(len(GENRES_LIST)):
#             genre = {
#                 "Genre_ID": GENRES["Genre_ID"][i],
#                 "Name": GENRES["Name"][i],
#                 "Description": GENRES["Description"][i]
#             }
#             file.write(f"\"Genre #{i+1}\": {json.dumps(genre)},")
#             file.write("\n")

#         for i in range(len(LANGUAGE_LIST)):
#             language = {
#                 "Language_ID": LANGUAGES["Language_ID"][i],
#                 "LanguageName": LANGUAGES["LanguageName"][i]
#             }
#             file.write(f"\"Language #{i+1}\": {json.dumps(language)},")
#             file.write("\n")

#         file.write(f"\"TotalBooks\":" + str(NUM_BOOKS) + ",\n")
#         file.write(f"\"TotalAuthors\":" + str(NUM_AUTHORS) + ",\n")
#         file.write(f"\"TotalPublishers:\":" + str(NUM_PUBLISHERS) + ",\n")
#         file.write(f"\"TotalLocations:\":" + str(NUM_LOCATIONS) + "\n")
#         file.write("}")


# Save each data into a PostgreSQL script

def save_to_sql_script(folder = "./Stage1/Data_Samples"):
    print(f"Saving data to SQL scripts in {folder}...")
    os.makedirs(folder, exist_ok=True)     # Ensure the directory exists
    with open(f"{folder}/random_books.sql", "w+") as file:    #  if file doesnt exist, create it (w+)

        file.write(BOOK_SCRIPT)
        for i in range(NUM_BOOKS):
            file.write(f"('{BOOKS['Title'][i]}', {BOOKS['ID'][i]}, '{BOOKS['Release_Date'][i]}', {BOOKS['Page_Count'][i]}, '{BOOKS['Format'][i]}', '{BOOKS['Description'][i]}', {BOOKS['ISBN'][i]})")            
            if i != NUM_BOOKS - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")
    with open(f"{folder}/random_locations.sql", "w+") as file:
        file.write(LOCATION_SCRIPT)
        for i in range(NUM_LOCATIONS):
            file.write(f"({LOCATIONS['Quantity'][i]}, '{LOCATIONS['Floor'][i]}', {LOCATIONS['Shelf'][i]}, {LOCATIONS['Location_ID'][i]}, '{LOCATIONS['Condition'][i]}', {LOCATIONS['ID'][i]})")
            if i != NUM_LOCATIONS - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")
    with open(f"{folder}/random_authors.sql", "w+") as file:
        file.write(AUTHOR_SCRIPT)
        for i in range(NUM_AUTHORS):
            file.write(f"('{AUTHORS['First_Name'][i]}', '{AUTHORS['Last_Name'][i]}', '{AUTHORS['Date_of_Birth'][i]}', {AUTHORS['Author_ID'][i]}, '{AUTHORS['Biography'][i]}')")
            if i != NUM_AUTHORS - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")
    with open(f"{folder}//random_publishers.sql", "w+") as file:
        file.write(PUBLISHER_SCRIPT)
        for i in range(NUM_PUBLISHERS):
            file.write(f"('{PUBLISHERS['Name'][i]}', '{PUBLISHERS['Phone_Number'][i]}', '{PUBLISHERS['Website'][i]}', {PUBLISHERS['Publisher_ID'][i]})")
            if i != NUM_PUBLISHERS - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")
    with open(f"{folder}/random_countries.sql", "w+") as file:
        file.write(COUNTRY_SCRIPT)
        for i in range(len(COUNTRIES_LIST)):
            file.write(f"('{COUNTRIES['Name'][i]}', {COUNTRIES['Country_ID'][i]})")
            if i != len(COUNTRIES_LIST) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")
    with open(f"{folder}/random_genres.sql", "w+") as file:
        file.write(GENRE_SCRIPT)
        for i in range(len(GENRES_LIST)):
            file.write(f"('{GENRES['Name'][i]}', '{GENRES['Description'][i]}', {GENRES['Genre_ID'][i]})")
            if i != len(GENRES_LIST) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")
    with open(f"{folder}/random_languages.sql", "w+") as file:
        file.write(LANGUAGE_SCRIPT)
        for i in range(len(LANGUAGE_LIST)):
            file.write(f"({LANGUAGES['Language_ID'][i]}, '{LANGUAGES['Name'][i]}')")
            if i != len(LANGUAGE_LIST) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")
    # generate tables for the other relations
    with open(f"{folder}/written_by.sql", "w+") as file:
        file.write(WRITTEN_BY_SCRIPT)
        for i in range(len(WRITTEN_BY["ID"])):
            file.write(f"({WRITTEN_BY['ID'][i]}, {WRITTEN_BY['Author_ID'][i]})")
            if i != len(WRITTEN_BY["ID"]) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

    with open(f"{folder}/published_by.sql", "w+") as file:
        file.write(PUBLISHED_BY_SCRIPT)
        for i in range(len(PUBLISHED_BY["ID"])):
            file.write(f"({PUBLISHED_BY['ID'][i]}, {PUBLISHED_BY['Publisher_ID'][i]})")
            if i != len(PUBLISHED_BY["ID"]) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

    with open(f"{folder}/written_in.sql", "w+") as file:
        file.write(WRITTEN_IN_SCRIPT)
        for i in range(len(WRITTEN_IN["ID"])):
            file.write(f"({WRITTEN_IN['ID'][i]}, {WRITTEN_IN['Language_ID'][i]})")
            if i != len(WRITTEN_IN["ID"]) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

    with open(f"{folder}/type_of.sql", "w+") as file:
        file.write(TYPE_OF_SCRIPT)
        for i in range(len(TYPE_OF["ID"])):
            file.write(f"({TYPE_OF['ID'][i]}, {TYPE_OF['Genre_ID'][i]})")
            if i != len(TYPE_OF["ID"]) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

    with open(f"{folder}/is_in.sql", "w+") as file:
        file.write(IS_IN_SCRIPT)
        for i in range(len(IS_IN["Publisher_ID"])):
            file.write(f"({IS_IN['Publisher_ID'][i]}, {IS_IN['Country_ID'][i]})")
            if i != len(IS_IN["Publisher_ID"]) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

# Main function to generate and save data
def main():
    generate_data()
    # save_to_json_file()
    save_to_sql_script(folder = "./data")

if __name__ == "__main__":
    main()
