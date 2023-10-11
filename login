import sqlite3

# Initialize the SQLite database
conn = sqlite3.connect('mentorship.db')
cursor = conn.cursor()

# Create a table for users
cursor.execute('''
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        user_type TEXT NOT NULL
    )
''')

conn.commit()

# Function to register a new user
def register_user():
    username = input("Enter a username: ")
    password = input("Enter a password: ")
    user_type = input("Are you a mentor or mentee? ")

    cursor.execute("INSERT INTO users (username, password, user_type) VALUES (?, ?, ?)",
                   (username, password, user_type))
    conn.commit()
    print("Registration successful!")

# Function to log in
def login_user():
    username = input("Enter your username: ")
    password = input("Enter your password: ")

    cursor.execute("SELECT * FROM users WHERE username = ? AND password = ?", (username, password))
    user = cursor.fetchone()

    if user:
        user_id, username, _, user_type = user
        print(f"Login successful! Welcome, {username} ({user_type}).")
    else:
        print("Invalid username or password. Please try again.")

# Main program loop
while True:
    print("\nWelcome to the Mentor-Mentee Research Mentorship Program")
    print("1. Register")
    print("2. Login")
    print("3. Exit")
    
    choice = input("Enter your choice: ")
    
    if choice == "1":
        register_user()
    elif choice == "2":
        login_user()
    elif choice == "3":
        print("Goodbye!")
        conn.close()
        break
    else:
        print("Invalid choice. Please select a valid option.")
