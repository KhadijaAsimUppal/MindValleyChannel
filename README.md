MindValleyChannel
This project is a demonstration of an iOS application for the Mindvalley Channel, implementing features like offline caching, data persistence using Core Data, and fetching episodes, channels, and categories data from a network API. The application uses an MVVM architecture with Combine for data binding, ensuring a clean separation of concerns and responsiveness in UI updates.

Features:

- Fetches episodes, channels, and categories from a network API.
- Provides offline support with Core Data for caching and fetching data when the network is unavailable.
- Uses Combine for reactive data updates between ViewModel and View.
- Displays New Episodes and Channels as horizontally scrollable lists, showing up to six items per row.
- Implements dynamic UI that displays series information if available in the channel; otherwise, it defaults to course display.


Project Structure:

- Model: Contains models for API responses and Core Data entities.
- ViewModel: Manages data fetching, processing, and Core Data caching.
- ViewController: Renders UI, handles user interaction, and binds to the ViewModel.


Challenges Faced:

- Core Data Integration: Implementing Core Data caching alongside network fetching introduced complexity, especially in managing asynchronous saves and fetching data with Combine. Handling entity uniqueness checks to avoid duplicates while ensuring data integrity required careful attention.
Reactive Binding with Combine: Ensuring the UI reacted appropriately to data updates from the ViewModel, especially in scenarios with both cached data and new network data.


Future Enhancements:

- Personalized Recommendations
Adding a personalized recommendation feature would greatly improve the app experience by providing content tailored to each user’s interests and preferences. This feature would analyze user interaction data, such as frequently viewed channels, preferred categories, and highly engaged episodes, to recommend new content that suits their tastes.
We could start with a simple recommendation algorithm that suggests episodes based on recent user activity. As the feature evolves, it could incorporate machine learning to offer more sophisticated, data-driven recommendations, possibly powered by a backend recommendation engine. By constantly offering fresh and personalized suggestions, the app would feel more engaging, encouraging users to return to explore content that resonates with them.
This enhancement would not only make the app more interactive but could also help boost user satisfaction and retention by continually offering relevant content.


Installation:

- Clone the repository.
- Open MindValleyChannel.xcodeproj in Xcode.
- Run the project on the simulator or a connected device.
