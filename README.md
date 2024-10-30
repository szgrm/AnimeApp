[<img src="https://github.com/user-attachments/assets/37d8ab31-66cc-4a08-953e-68dc01e395ff" height="100" />](https://github.com/szgrm/AnimeApp) [<img src="https://github.com/user-attachments/assets/7d5a9658-77a1-4561-a28c-ba1d65458b84" height="100" />](https://docs.anilist.co/)

# AnimeApp


AnimeApp is a SwiftUI-based iOS application that allows users to explore and discover anime titles and characters. It provides an interface to browse popular animes and characters, view detailed information about characters and animes search for specific titles. The app leverages the [AnilistAPI](https://docs.anilist.co/) for fetching anime and character data.

## Screenshots and GIF


<img src="https://github.com/user-attachments/assets/ac7fc54b-c4ad-4309-8b99-9b01ed312ba2" height="400" />


<img src="https://github.com/user-attachments/assets/ade4f825-79b6-4911-9da9-aea2580a15d4" height="400" />



## Technologies Used

- [<img src="https://github.com/user-attachments/assets/9ad11072-16d1-43aa-b0ae-13f372c168b2" height="50" />](https://developer.apple.com/documentation/swiftui/) Swift SwiftUI 

- [<img src="https://github.com/user-attachments/assets/9ea2bdb2-315a-456a-8a11-e599a23d0da7" height="50" />](https://github.com/apollographql/apollo-ios) Apollo GraphQL

- [<img src="https://github.com/user-attachments/assets/ffadf5da-db66-487f-8ba8-58f469cb593d" height="50" />](https://github.com/kean/Nuke) Nuke

- [<img src="https://github.com/user-attachments/assets/919734cf-9a8c-4643-887b-a4aad561d7ad" height="50" />](https://lottiefiles.com/) Lottie


## Running on Your Machine

To run this project locally, follow these steps:

1. Clone the repository
   ```
   git clone https://github.com/szgrm/AnimeApp.git
   ```

2. Navigate to the project directory
   ```
   cd AnimeApp
   ```

3. Compile the apollo command line tool to be able to fetch the schema, and generate code.

   ```
   swift package --allow-writing-to-package-directory apollo-cli-install
   ```

4. Fetch the schema
   ```
   ./apollo-ios-cli fetch-schema
   ```

5. Generate code
   ```
   ./apollo-ios-cli generate
   ```

6. Open the project in Xcode
   ```
   open AnimeApp.xcworkspace
   ```
7. Build and run the project in Xcode

Note: This project uses Swift Package Manager for dependency management, which should automatically resolve dependencies when you open the project in Xcode.

## Features

- Browse popular anime and characters
- Search for specific anime or characters
- View detailed information about animes including descriptions and characters
- Explore character profiles 
- Support for dark and light mode  
- Support for interfaces in Turkish and Japanese in addition to English

## Roadmap

- [x] Implement user authentication
- [ ] Add favorite anime and character lists
- [ ] Add sorting and filtering features for lists

