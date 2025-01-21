import random
import json
from faker import Faker
import os
from datetime import datetime
# Initialize Faker for random realistic data
faker = Faker("en_US")
Faker.seed(4321) # set to a fixed seed for reproducibility

# SQL Statements
BOOK_SCRIPT = 'INSERT INTO Book (Title, ID, Release_Date, Page_Count, Format, Description, ISBN, Rarity) VALUES'
LOCATION_SCRIPT = 'INSERT INTO Location (Quantity, Floor, Shelf, Location_ID, Condition, ID, Archive_Number) VALUES'
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

EMPLOYEE_SCRIPT = 'INSERT INTO Employee (Role, Age, Salary, Employee_ID, Name) VALUES'
ARCHIVE_SCRIPT = 'INSERT INTO Archive (Archive_Number, Book_Type) VALUES'
DISPOSAL_SCRIPT = 'INSERT INTO Disposal (Date, Disposal_ID, Method, Material_of_Book, ID, Employee_ID) VALUES'
UPKEEP_SCRIPT = 'INSERT INTO Upkeep (Upkeep_ID, Tools_used, Reason_for_upkeep, Date, ID, Employee_ID) VALUES'
ARCHIVAL_ASSIGNMENT_SCRIPT = 'INSERT INTO Archival_Assignment (Assignment_ID, Date, ID, Employee_ID, Archive_Number, New_LocationArchive_Number) VALUES'

# give a count digit number (as a string)
def generate_number(count):
    num = ""
    for i in range(count):
        num += str(random.randint(0, 9))
    return num

# Generate unique random numbers
def generate_unique_id(existing_ids, digits=9, fix_len=False):
    new_id = faker.random_number(digits=digits, fix_len=fix_len)
    while new_id in existing_ids:
        new_id = faker.random_number(digits=digits, fix_len=fix_len)
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
NUM_EMPLOYEES = 1000

# List of random data
COUNTRIES_LIST = ["USA", "Canada", "Mexico", "Brazil", "Argentina", "Chile", "UK", "Germany", "France", "Italy", "Spain", "Russia", "China", "Japan", "India", "Australia", "South Africa", "Nigeria", "Egypt", "Saudi Arabia", "Iran", "South Korea", "North Korea", "Uzbekistan"]
GENRES_LIST = ['Accounting', 'Anthropology', 'Art', 'Autobiography', 'Biography', 'Biology', 'Business', 'Chemistry', "Children", 'Comics', 'Computer Science', 'Consulting', 'Cooking', 'Criminal Justice', 'Customer Service', 'Dance', 'Dentistry', 'Drama', 'Economics', 'Education', 'Engineering', 'Entrepreneurship', 'Fantasy', 'Fiction', 'Film', 'Finance', 'Fitness', 'Geography', 'Graphic Novel', 'Health', 'History', 'Horror', 'Human Resources', 'Information Technology', 'Innovation', 'Journalism', 'Law', 'Leadership', 'Literature', 'Logistics', 'Management', 'Marketing', 'Mathematics', 'Medicine', 'Music', 'Mystery', 'Non-Fiction', 'Nursing', 'Operations', 'Pharmacy', 'Philosophy', 'Physics', 'Poetry', 'Political Science', 'Politics', 'Psychiatry', 'Psychology', 'Radio', 'Religion', 'Romance', 'Sales', 'Science', 'Science Fiction', 'Self-Help', 'Sociology', 'Spirituality', 'Sports', 'Strategy', 'Supply Chain', 'Technology', 'Television', 'Theatre', 'Theology', 'Thriller', 'Travel', 'Veterinary', 'Young Adult']
LANGUAGE_LIST = ["English", "Spanish", "French", "German", "Italian", "Portuguese", "Dutch", "Russian","Amharic","Aramaic", "Mandarin", "Japanese", "Korean", "Latin", "Hindi", "Bengali", "Urdu", "Punjabi", "Telugu", "Marathi", "Tamil", "Gujarati", "Kannada", "Odia", "Malayalam", "Sindhi", "Sanskrit", "Persian", "Turkish", "Greek", "Swedish", "Norwegian", "Danish", "Finnish", "Icelandic", "Polish", "Czech", "Slovak", "Hungarian", "Romanian", "Bulgarian", "Serbian", "Croatian", "Bosnian", "Slovenian", "Macedonian", "Albanian", "Greek", "Armenian", "Georgian", "Azerbaijani", "Kazakh", "Uzbek", "Turkmen", "Kyrgyz", "Tajik", "Pashto", "Balochi", "Kurdish", "Arabic", "Hebrew", "Yiddish", "Braille"]
CONDITION_LIST = ["Like New", "Found", "Dusty", "Bought", "Worn", "Very Good", "Good", "Stained", "Acceptable", "Moldy", "New", "Yellowed", "Torn", "Damaged", "Expired", "Discontinued", "Scratched", "Outdated", "Obsolete", "Dirty", "Rare", "Broken", "Incomplete", "Chipped","Stolen", "Aged", "Cracked", "Missing", "Faulty",  "Defective", "Poor", "Faded"]
BOOKFORMAT_LIST = ["Dictionary", "Library", "Yearbook", "Newsletter", "Poster",  "Audiobook", "Textbook", "Journal",  "Encyclopedia", "Guide", "Calendar", "Scrapbook", "Hardcover", "Album", "Brochure", "Planner", "Ebook", "Notebook", "Record", "Mass Market Paperback", "Manual", "Flyer", "Newspaper", "Reference", "Diary", "Magazine", "Almanac", "Large Print", "Paperback", "Atlas", "Handbook"]
FLOOR = ["Storage", "Maintenance", "Returns", "Kids Corner", "Young Adult Section", "Adult Section", "Reference Section", "Study Area", "Computer Lab", "History Section", "Periodicals","E-Library Section", "Audio-Visual Section", "Special Collections", "Archive"]

ROLES = ["Archivist", "Restorationist", "Disposal Worker"]
ARCHIVE_NUMBERS = list(range(1, 51))
BOOK_TYPES = ["Governmental", "Law", "Academic", "Historical Document", "Scroll", "General Purpose"]
CAPACITY_VALUES = [i * 1000 for i in range(10, 21)]
MATERIALS = ['Paper', 'Leather', 'Synthetic', 'Metal']
METHODS = ['Incineration', 'Recycling', 'Donation', 'Burial', 'Shredding', 'Repurposing']
TOOLS = ["Glue", "Scissors", "Brush", "Tweezers", "Clamps", "Scalpel", "Binding Tape"]
REASONS = ["Torn pages", "Loose binding", "Water damage", "Faded text", "Mold growth", "Dust accumulation", "Staining", "Cover damage","Insect damage", "Aging and brittleness"]
RARITY = ['Common', 'Rare', 'Very Rare', 'Legendary']

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
    "Release_Date": [],
    "Rarity": []
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
    "ID": [],  # Foreign key to Book(ID)
    "Archive_Number": []
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

EMPLOYEE = {
    "Employee_ID": [],
    "Name": [],
    "Role": [],
    "Age": [],
    "Salary": []
}

ARCHIVE = {
    "Archive_Number": [],
    "Book_Type": []
}

DISPOSAL = {
    "Disposal_ID": [],
    "Date": [],
    "Method": [],
    "Material_of_Book": [],
    "ID": [],          # Foreign key to Book(ID)
    "Employee_ID": []  # Foreign key to Employee(Employee_ID)
}

UPKEEP = {
    "Upkeep_ID": [],
    "Tools_used": [],
    "Reason_for_upkeep": [],
    "Date": [],
    "ID": [],          # Foreign key to Book(ID)
    "Employee_ID": []  # Foreign key to Employee(Employee_ID)
}

ARCHIVAL_ASSIGNMENT = {
    "Assignment_ID": [],
    "Date": [],
    "ID": [],          # Foreign key to Book(ID)
    "Employee_ID": [], # Foreign key to Employee(Employee_ID)
    "Archive_Number": [],
    "New_LocationArchive_Number": []
}

# Generate random data
def generate_data(num_books=NUM_BOOKS, num_authors=NUM_AUTHORS, num_publishers=NUM_PUBLISHERS, num_locations=NUM_LOCATIONS, num_employees=NUM_EMPLOYEES):
    print(f"Generating {num_books} books, {num_authors} authors, {num_publishers} publishers, and {num_locations} locations...")
    # generate countries
    for i in range(len(COUNTRIES_LIST)):
        COUNTRIES["Country_ID"].append(i) # sequential country id
        COUNTRIES["Name"].append(COUNTRIES_LIST[i])

    # Generate publishers
    for i in range(num_publishers):
        PUBLISHERS["Publisher_ID"].append(i) # ensure unique
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
        AUTHORS["Author_ID"].append(generate_unique_id(unique_author_ids, digits=9, fix_len=True))
        AUTHORS["First_Name"].append(faker.first_name())
        AUTHORS["Last_Name"].append(faker.last_name())
        AUTHORS["Biography"].append(faker.paragraph())
        AUTHORS["Date_of_Birth"].append(generate_date())

    unique_isbn = set()
    # Generate books
    for i in range(num_books):
        BOOKS["ID"].append(i)
        BOOKS["Title"].append(faker.sentence())
        BOOKS["ISBN"].append(generate_unique_id(unique_isbn, digits=9, fix_len=True)) # original isbn standard
        BOOKS["Page_Count"].append(faker.random_number(digits=3) +1)
        BOOKS["Format"].append(faker.random_element(BOOKFORMAT_LIST))
        BOOKS["Description"].append(faker.paragraph())
        BOOKS["Release_Date"].append(generate_date(start="1850-01-01", end="2024-01-01"))
        BOOKS["Rarity"].append(faker.random_element(RARITY))

    # generate locations
    for i in range(num_locations):
        LOCATIONS["Location_ID"].append(i)
        LOCATIONS["Shelf"].append(faker.random_number(digits=2)+1)
        LOCATIONS["Floor"].append(random.choice(FLOOR))
        LOCATIONS["Quantity"].append(faker.random_number(digits=2) +1)
        LOCATIONS["Condition"].append(random.choice(CONDITION_LIST))
        LOCATIONS["ID"].append(BOOKS["ID"][random.randint(0, num_books - 1)])
        LOCATIONS["Archive_Number"].append(random.choice(ARCHIVE_NUMBERS))

    # generate relations for written_by
    for book_index in range(num_books):
        already_written_list = []
        for author_amount in range(1, random.randint(1, 5)): # 1 to 5 authors for one book
            author_index = random.randint(0, num_authors - 1) # random author
            if AUTHORS["Date_of_Birth"][author_index] < BOOKS["Release_Date"][book_index] and AUTHORS["Author_ID"][author_index] not in already_written_list: # author must be born before the book is released and not already added
                WRITTEN_BY["ID"].append(BOOKS["ID"][book_index])
                WRITTEN_BY["Author_ID"].append(AUTHORS["Author_ID"][author_index])
                already_written_list.append(AUTHORS["Author_ID"][author_index])
        if not WRITTEN_BY["ID"]: # if no author is found, add a random author
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
    unique_genre_pairs = set()  # To keep track of unique (Book_ID, Genre_ID) pairs
    for i in range(num_books):
        genre_index = random.randint(0, len(GENRES_LIST) - 1)
        if (BOOKS["ID"][i], GENRES["Genre_ID"][genre_index]) not in unique_genre_pairs:
            TYPE_OF["ID"].append(BOOKS["ID"][i])
            TYPE_OF["Genre_ID"].append(GENRES["Genre_ID"][genre_index])
            unique_genre_pairs.add((BOOKS["ID"][i], GENRES["Genre_ID"][genre_index]))
        # now check for additional genres with a 20% chance
        fake = faker.boolean(chance_of_getting_true=20)
        while fake:
            genre_index = random.randint(0, len(GENRES_LIST) - 1)
            if (BOOKS["ID"][i], GENRES["Genre_ID"][genre_index]) not in unique_genre_pairs:
                TYPE_OF["ID"].append(BOOKS["ID"][i])
                TYPE_OF["Genre_ID"].append(GENRES["Genre_ID"][genre_index])
                unique_genre_pairs.add((BOOKS["ID"][i], GENRES["Genre_ID"][genre_index]))
            fake = faker.boolean(chance_of_getting_true=20)
        
            
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

    # generate employees
    for i in range(num_employees):
        EMPLOYEE["Employee_ID"].append(i)
        EMPLOYEE["Name"].append(faker.name())
        EMPLOYEE["Role"].append(random.choice(ROLES))
        EMPLOYEE["Age"].append(random.randint(20, 70))
        EMPLOYEE["Salary"].append(faker.random_number(digits=5))

    # generate archives
    for i in range(len(ARCHIVE_NUMBERS)):
        ARCHIVE["Archive_Number"].append(ARCHIVE_NUMBERS[i])
        ARCHIVE["Book_Type"].append(random.choice(BOOK_TYPES))

    # generate disposals
    for i in random.sample(range(num_books), int(num_books * 0.1)): # 10% of books
        DISPOSAL["Disposal_ID"].append(i)
        DISPOSAL["Date"].append(generate_date())
        DISPOSAL["Method"].append(random.choice(METHODS))
        DISPOSAL["Material_of_Book"].append(random.choice(MATERIALS))
        DISPOSAL["ID"].append(BOOKS["ID"][random.randint(0, num_books - 1)])
        DISPOSAL["Employee_ID"].append(random.randint(0, num_employees - 1))

    # generate upkeep
    for i in random.sample(range(num_books), int(num_books * 0.1)): # 10% of books
        UPKEEP["Upkeep_ID"].append(i)
        UPKEEP["Tools_used"].append(random.choice(TOOLS))
        UPKEEP["Reason_for_upkeep"].append(random.choice(REASONS))
        UPKEEP["Date"].append(generate_date())
        UPKEEP["ID"].append(BOOKS["ID"][random.randint(0, num_books - 1)])
        UPKEEP["Employee_ID"].append(random.randint(0, num_employees - 1))

    # generate archival assignments
    for i in random.sample(range(num_books), int(num_books * 0.1)): # 10% of books
        ARCHIVAL_ASSIGNMENT["Assignment_ID"].append(i)
        ARCHIVAL_ASSIGNMENT["Date"].append(generate_date())
        ARCHIVAL_ASSIGNMENT["ID"].append(BOOKS["ID"][random.randint(0, num_books - 1)])
        ARCHIVAL_ASSIGNMENT["Employee_ID"].append(random.randint(0, num_employees - 1))
        ARCHIVAL_ASSIGNMENT["Archive_Number"].append(random.choice(ARCHIVE_NUMBERS))
        ARCHIVAL_ASSIGNMENT["New_LocationArchive_Number"].append(random.choice(ARCHIVE_NUMBERS))



# Save each data into a PostgreSQL script

def save_to_sql_script(folder = "./Stage4/Data_Samples/"):
    print(f"Saving data to SQL scripts in {folder}...")
    os.makedirs(folder, exist_ok=True)     # Ensure the directory exists
    with open(f"{folder}/random_books.sql", "w+") as file:    #  if file doesnt exist, create it (w+)

        file.write(BOOK_SCRIPT)
        for i in range(NUM_BOOKS):
            file.write(f"('{BOOKS['Title'][i]}', {BOOKS['ID'][i]}, '{BOOKS['Release_Date'][i]}', {BOOKS['Page_Count'][i]}, '{BOOKS['Format'][i]}', '{BOOKS['Description'][i]}', {BOOKS['ISBN'][i]}, '{BOOKS['Rarity'][i]}')")           
            if i != NUM_BOOKS - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")
    with open(f"{folder}/random_locations.sql", "w+") as file:
        file.write(LOCATION_SCRIPT)
        for i in range(NUM_LOCATIONS):
            file.write(f"({LOCATIONS['Quantity'][i]}, '{LOCATIONS['Floor'][i]}', {LOCATIONS['Shelf'][i]}, {LOCATIONS['Location_ID'][i]}, '{LOCATIONS['Condition'][i]}', {LOCATIONS['ID'][i]}, {LOCATIONS['Archive_Number'][i]})")
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

    with open(f"{folder}/employees.sql", "w+") as file:
        file.write(EMPLOYEE_SCRIPT)
        for i in range(len(EMPLOYEE["Employee_ID"])):
            file.write(f"('{EMPLOYEE['Role'][i]}', {EMPLOYEE['Age'][i]}, {EMPLOYEE['Salary'][i]}, {EMPLOYEE['Employee_ID'][i]}, '{EMPLOYEE['Name'][i]}')")
            if i != len(EMPLOYEE["Employee_ID"]) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

    with open(f"{folder}/archives.sql", "w+") as file:
        file.write(ARCHIVE_SCRIPT)
        for i in range(len(ARCHIVE["Archive_Number"])):
            file.write(f"({ARCHIVE['Archive_Number'][i]}, '{ARCHIVE['Book_Type'][i]}')")
            if i != len(ARCHIVE["Archive_Number"]) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

    with open(f"{folder}/disposals.sql", "w+") as file:
        file.write(DISPOSAL_SCRIPT)
        for i in range(len(DISPOSAL["Disposal_ID"])):
            file.write(f"('{DISPOSAL['Date'][i]}', {DISPOSAL['Disposal_ID'][i]}, '{DISPOSAL['Method'][i]}', '{DISPOSAL['Material_of_Book'][i]}', {DISPOSAL['ID'][i]}, {DISPOSAL['Employee_ID'][i]})")
            if i != len(DISPOSAL["Disposal_ID"]) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

    with open(f"{folder}/upkeep.sql", "w+") as file:
        file.write(UPKEEP_SCRIPT)
        for i in range(len(UPKEEP["Upkeep_ID"])):
            file.write(f"({UPKEEP['Upkeep_ID'][i]}, '{UPKEEP['Tools_used'][i]}', '{UPKEEP['Reason_for_upkeep'][i]}', '{UPKEEP['Date'][i]}', {UPKEEP['ID'][i]}, {UPKEEP['Employee_ID'][i]})")
            if i != len(UPKEEP["Upkeep_ID"]) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

    with open(f"{folder}/archival_assignments.sql", "w+") as file:
        file.write(ARCHIVAL_ASSIGNMENT_SCRIPT)
        for i in range(len(ARCHIVAL_ASSIGNMENT["Assignment_ID"])):
            file.write(f"({ARCHIVAL_ASSIGNMENT['Assignment_ID'][i]}, '{ARCHIVAL_ASSIGNMENT['Date'][i]}', {ARCHIVAL_ASSIGNMENT['ID'][i]}, {ARCHIVAL_ASSIGNMENT['Employee_ID'][i]}, {ARCHIVAL_ASSIGNMENT['Archive_Number'][i]}, {ARCHIVAL_ASSIGNMENT['New_LocationArchive_Number'][i]})")
            if i != len(ARCHIVAL_ASSIGNMENT["Assignment_ID"]) - 1:
                file.write(",\n")
            else:
                file.write(";\n\n")

    print("Data saved to SQL scripts.")

# Main function to generate and save data
def main():
    generate_data()
    # save_to_json_file()
    save_to_sql_script(folder = "./Stage4/Data_Samples/data")

if __name__ == "__main__":
    main()
