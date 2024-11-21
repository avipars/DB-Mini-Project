import random
import json
from faker import Faker

# function to generate if the book is been fixed or not
def generate_condition_occurance_time(occurance_time):
    is_fixed = faker.boolean(chance_of_getting_true=50)
    if is_fixed:
        occur_year = occurance_time.split('/')[1]
        fixed_year = random.randint(int(occur_year)+1, 2024)
        return f"{random.randint(1, 12)}/{fixed_year}"
    return null

# function to generate if the book is in condition or not
def generate_if_condition():
    is_broken = faker.boolean(chance_of_getting_true=50)
    if is_broken:
        return random.choice(data["conditions"])["cond_id"]
    return null

# Initialize Faker for random realistic data
faker = Faker()

num_books = 10
num_authors = 5
num_publishers = 3

# List of random data
cond_location_list = ["on top", "on the bottom", "on the side", "in the middle", "in the right corner", "in the left corner", "in the front", "in the back", "in the center", "on the edge"]
countries_list = ["USA", "Canada", "Mexico", "Brazil", "Argentina", "Chile", "UK", "Germany", "France", "Italy", "Spain", "Russia", "China", "Japan", "India", "Australia", "South Africa", "Nigeria", "Egypt", "Saudi Arabia"]
genres_list = ["Fiction", "Non-Fiction", "Science", "History", "Romance", "Mystery", "Thriller", "Horror", "Fantasy", "Biography", "Autobiography", "Self-Help", "Cooking", "Travel", "Poetry", "Drama", "Comics", "Graphic Novel", "Science Fiction", "Young Adult", "Children's", "Art", "Music", "Sports", "Health", "Fitness", "Business", "Finance", "Economics", "Politics", "Philosophy", "Religion", "Spirituality", "Psychology", "Sociology", "Anthropology", "Education", "Technology", "Engineering", "Mathematics", "Physics", "Chemistry", "Biology", "Medicine", "Nursing", "Psychiatry", "Dentistry", "Pharmacy", "Veterinary", "Law", "Criminal Justice", "History", "Geography", "Economics", "Political Science", "Sociology", "Psychology", "Anthropology", "Philosophy", "Religion", "Theology", "Art", "Music", "Theatre", "Dance", "Film", "Television", "Radio", "Journalism", "Literature", "Poetry", "Fiction", "Non-Fiction", "Science Fiction", "Fantasy", "Mystery", "Thriller", "Horror", "Romance", "Young Adult", "Children's", "Biography", "Autobiography", "Self-Help", "Cooking", "Travel", "History", "Science", "Mathematics", "Physics", "Chemistry", "Biology", "Medicine", "Nursing", "Psychiatry", "Dentistry", "Pharmacy", "Veterinary", "Engineering", "Technology", "Computer Science", "Information Technology", "Business", "Finance", "Economics", "Marketing", "Management", "Accounting", "Human Resources", "Operations", "Supply Chain", "Logistics", "Sales", "Customer Service", "Entrepreneurship", "Innovation", "Leadership", "Strategy", "Consulting", "Law", "Criminal Justice", "Political Science", "Sociology", "Psychology", "Anthropology", "Philosophy", "Religion"]
languages_list = ["English", "Spanish", "French", "German", "Italian", "Portuguese", "Dutch", "Russian", "Chinese", "Japanese", "Korean", "Arabic", "Hindi", "Bengali", "Urdu", "Punjabi", "Telugu", "Marathi", "Tamil", "Gujarati", "Kannada", "Odia", "Malayalam", "Sindhi", "Sanskrit", "Persian", "Turkish", "Greek", "Swedish", "Norwegian", "Danish", "Finnish", "Icelandic", "Polish", "Czech", "Slovak", "Hungarian", "Romanian", "Bulgarian", "Serbian", "Croatian", "Bosnian", "Slovenian", "Macedonian", "Albanian", "Greek", "Armenian", "Georgian", "Azerbaijani", "Kazakh", "Uzbek", "Turkmen", "Kyrgyz", "Tajik", "Pashto", "Balochi", "Kurdish", "Arabic", "Hebrew", "Yiddish"]
cond_type_list = ["New", "Like New", "Very Good", "Good", "Acceptable", "Poor", "Damaged", "Worn", "Torn", "Stained", "Faded", "Yellowed", "Aged", "Moldy", "Musty", "Dusty", "Dirty", "Scratched", "Cracked", "Chipped", "Broken", "Missing", "Incomplete", "Defective", "Faulty", "Expired", "Outdated", "Obsolete", "Discontinued", "Rare", "Limited Edition", "First Edition", "Signed", "Autographed", "Dedicated", "Inscribed", "Personalized", "Gifted", "Donated", "Borrowed", "Stolen", "Lost", "Found", "Recovered", "Returned", "Sold", "Purchased", "Bought", "Traded", "Exchanged", "Given", "Received", "Acquired", "Owned", "Possessed", "Kept", "Stored", "Displayed", "Showcased", "Presented", "Gifted", "Donated", "Lent", "Borrowed", "Returned", "Lost", "Found", "Stolen", "Recovered", "Sold", "Purchased", "Bought", "Traded", "Exchanged", "Given", "Received", "Acquired", "Owned", "Possessed", "Kept", "Stored", "Displayed", "Showcased", "Presented", "Gifted", "Donated", "Lent", "Borrowed", "Returned", "Lost", "Found", "Stolen", "Recovered", "Sold", "Purchased", "Bought", "Traded", "Exchanged", "Given", "Received", "Acquired", "Owned", "Possessed", "Kept", "Stored", "Displayed", "Showcased", "Presented", "Gifted", "Donated", "Lent", "Borrowed", "Returned", "Lost", "Found", "Stolen", "Recovered", "Sold", "Purchased", "Bought", "Traded", "Exchanged", "Given", "Received", "Acquired", "Owned", "Possessed", "Kept", "Stored", "Displayed", "Showcased", "Presented", "Gifted", "Donated", "Lent"]
book_format_list = ["Hardcover", "Paperback", "Ebook", "Audiobook", "Large Print", "Pocket", "Mass Market", "Trade", "Library", "Reference", "Textbook", "Workbook", "Guide", "Manual", "Handbook", "Dictionary", "Encyclopedia", "Atlas", "Almanac", "Yearbook", "Journal", "Magazine", "Newspaper", "Newsletter", "Brochure", "Pamphlet", "Leaflet", "Flyer", "Poster", "Postcard", "Bookmark", "Calendar", "Planner", "Diary", "Journal", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook", "Sketchbook", "Album", "Scrapbook", "Logbook", "Ledger", "Register", "Record", "Log", "Journal", "Diary", "Notebook"]
location_list = ["On bottom shelf", "On top shelf", "On middle shelf", "On left shelf", "On right shelf", "On front shelf", "On back shelf", "On side shelf", "On corner shelf", "On edge shelf", "On center shelf", "On top of stack", "On bottom of stack", "In front of stack", "Behind stack", "Beside stack", "Between stacks", "On top of pile", "On bottom of pile", "In front of pile", "Behind pile", "Beside pile", "Between piles", "On top of row", "On bottom of row", "In front of row", "Behind row", "Beside row", "Between rows", "On top of column", "On bottom of column", "In front of column", "Behind column", "Beside column", "Between columns", "On top of stack", "On bottom of stack", "In front of stack", "Behind stack", "Beside stack", "Between stacks", "On top of pile", "On bottom of pile", "In front of pile", "Behind pile", "Beside pile", "Between piles", "On top of row", "On bottom of row", "In front of row", "Behind row", "Beside row", "Between rows", "On top of column", "On bottom of column", "In front of column", "Behind column", "Beside column", "Between columns", "On top of stack", "On bottom of stack", "In front of stack", "Behind stack", "Beside stack", "Between stacks", "On top of pile", "On bottom of pile", "In front of pile", "Behind pile", "Beside pile", "Between piles", "On top of row", "On bottom of row", "In front of row", "Behind row", "Beside row", "Between rows", "On top of column", "On bottom of column", "In front of column", "Behind column", "Beside column", "Between columns", "On top of stack", "On bottom of stack", "In front of stack", "Behind stack", "Beside stack", "Between stacks", "On top of pile", "On bottom of pile", "In front of pile", "Behind pile", "Beside pile", "Between piles", "On top of row", "On bottom of row", "In front of"]


# Generate random data
def generate_data(num_books=10, num_authors=5, num_publishers=3):
    data = {
        "books": [],
        "authors": [],
        "publishers": [],
        "book_descriptions": [],
        "conditions": [],
        "country_of_origin": [],
        "genres": [],
        "languages": [],
        "condition_locations": [],
        "condition_types": [],
        "book_formats": [],
        "locations": [],
    }

    # generate conditions_locations
    for i, location in enumerate(cond_location_list):
        data["condition_locations"].append({
            "conloc_id": i,
            "location": location
        })

    # generate condition_types
    for i, condition in enumerate(cond_type_list):
        data["condition_types"].append({
            "cond_id": i,
            "condition": condition
        })

    # generate book_formats
    for i, format in enumerate(book_format_list):
        data["book_formats"].append({
            "format_id": i,
            "format": format
        })

    # generate countries
    for i, country in enumerate(countries_list):
        data["country_of_origin"].append({
            "country_id": i,
            "country": country
        })


    # generate genres
    for i, genre in enumerate(genres_list):
        data["genres"].append({
            "cat_id": i,
            "category": genre
        })

    # generate languages
    for i, language in enumerate(languages_list):
        data["languages"].append({
            "lang_id": i,
            "language": language
        })

    # generate book_descriptions
    for i in range(num_books):
        data["book_descriptions"].append({
            "description_id": i,
            "description": faker.text(max_nb_chars=500)
        })
        
    # Generate locations
    for i, location in enumerate(location_list):
        data["locations"].append({
            "loc_id": i,
            "location": location
        })

    # Generate conditions
    for i in range(10):
        data["conditions"].append({
            "cond_id": faker.uuid4(),
            "condition_occurance_time": f"{random.randint(1, 12)}/{random.randint(1990, 2024)}",
            "time_fixed": generate_condition_occurance_time(data["conditions"][i]["condition_occurance_time"]),
            "location": random.choice(data["condition_locations"])["conloc_id"],
            "type": random.choice(data["condition_types"])["cond_id"],
        })

    # Generate publishers
    for _ in range(num_publishers):
        publisher_id = faker.uuid4() # might no need this
        data["publishers"].append({
            "publisher_id": publisher_id,
            "name": faker.company(),
            "address": faker.address(),
            "phone": faker.phone_number(),
            "website": faker.url(),
        })

    # Generate authors
    for _ in range(num_authors):
        author_id = faker.uuid4()
        data["authors"].append({
            "author_id": author_id, # might no need this
            "name": faker.name(),
            "biography": faker.text(max_nb_chars=200),
            "date_of_birth": faker.date_of_birth(minimum_age=25, maximum_age=75).isoformat()
        })

    # Generate books
    for _ in range(num_books):
        book_id = faker.uuid4()
        data["books"].append({
            "book_id": book_id, # might no need this
            "title": faker.catch_phrase(),
            "isbn": faker.isbn13(), # this is a good point to think, we might want the isbn id to be in books instead of all other ids's we put there
            "publication": f"({random.randint(1,12)}/{random.randint(1990, 2024)})",
            "number_of_pages": random.randint(50, 1000),
            "chapter_count": random.randint(2, 50),
            "category": random.choice(data["genres"])["cat_id"],
            "language": random.choice(data["languages"])["lang_id"],
            "description": random.choice(data["book_descriptions"])["description_id"],
            "publisher_id": random.choice(data["publishers"])["publisher_id"],
            "author_ids": random.sample([author["author_id"] for author in data["authors"]], random.randint(1, num_authors)),
            "condition": generate_if_condition(),
        })

    return data

# Save data to a JSON file
def save_to_json_file(data, filename="sample_data.json"):
    with open(filename, "w") as file:
        json.dump(data, file, indent=4)
    print(f"Data successfully saved to {filename}")

# Generate and save data
if __name__ == "__main__":
    random_data = generate_data(num_books=20, num_authors=10, num_publishers=5)
    save_to_json_file(random_data)
