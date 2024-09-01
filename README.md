# TimeSync

TimeSync is a productivity tool designed to enhance communication among colleagues working remotely or across different time zones. By utilizing the Nylas API for accessing and managing contact information and integrating the Gemini LLM for intelligent decision-making, TimeSync ensures that your messages are sent at the most appropriate and effective times.

## Features

- **Time-Based Recommendations**: TimeSync analyzes the current time and your colleague's time zone to suggest the most suitable communication method. The red icons are discouraged if I wanted to talk to Maria given her local time, while the green icons are the recommended communication channels if I wanted to talk to Maria given her local time.
![Screenshot 2024-09-02 at 02 47 12](https://github.com/user-attachments/assets/80d74f8b-f006-4ade-94c3-3b171e985679)

- **Context-Aware Decisions**: Considers factors such as missed calls, unresponded messages, urgency, and previous interactions. Utilizes the **Gemini LLM** to provide tailored advice when you're uncertain about the best communication method.
![Screenshot 2024-09-02 at 02 51 45](https://github.com/user-attachments/assets/e7ef46ba-6e10-42a6-a0d4-31406a5e0dee)

- **Global Time Zone Support**: Efficiently manages communication across various time zones, ensuring alignment with your team. TimeSync shows what time it is in your contact's time zone. The color indicators additionally show whether your contact's time is still within the normal working hours or not.
![Screenshot 2024-09-02 at 02 52 24](https://github.com/user-attachments/assets/792d5049-c4e0-459d-aac2-5aa7aa06a7f7)

- **Nylas API Integration**: Fetches and manages contact information seamlessly, leveraging Nylas API to retrieve detailed contact data.
![Screenshot 2024-09-02 at 02 52 24](https://github.com/user-attachments/assets/792c025c-5038-44d3-a8e2-b6cd7f8a067f)

- **Simple and Intuitive Interface**: Features a user-friendly design that allows you to focus on effective communication without hassle.
![Screenshot 2024-09-02 at 02 55 43](https://github.com/user-attachments/assets/46507e0e-7d4f-4bbe-a412-e0b5d79792b6)


## Why TimeSync?

In today’s globalized work environment, remote teams are often spread across multiple time zones, making communication coordination challenging. TimeSync addresses these challenges by:

- **Improving Communication Efficiency**: Provides recommendations on the best communication method based on real-time context, reducing the risk of missed or ignored messages.
- **Boosting Productivity**: Ensures timely and effective communication, enhancing collaboration and making better use of working hours.
- **Enhancing Team Collaboration**: Uses intelligent suggestions to ensure that you communicate to your team members when they are most likely to respond, facilitating smoother interactions.

## Installation

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/TimeSync.git
   ```

2. Navigate to the project directory:

   ```bash
   cd TimeSync
   ```

3. Open the project in Xcode:

   ```bash
   open TimeSync.xcodeproj
   ```

4. Install dependencies if any (CocoaPods, Swift Packages, etc.):

   ```bash
   pod install
   ```

5. Build and run the project on a simulator or your device.

## Usage

1. **Set Up Contacts**: Import your contacts into the application using the Nylas API.

2. **View Recommendations**: Select a contact, and the app will suggest the best communication method based on the current time and other contextual factors, assisted by Gemini LLM. **Green for 'Recommended' and Red for 'Not Recommended'**

3. **Ask Gemini for Assistance**: When in doubt about whether to call, text, email, or schedule a meeting, use the integrated Gemini LLM to receive guidance tailored to your situation.

## Project Structure

- **Models:** Contains data models like
- **Views:** Has custom UI components.
- **View Controllers:** Manages application logic and user interactions.
- **Resources:** Assets, and other resource files.
- etc.
## Contributing

Contributions are welcome to TimeSync! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes.
4. Submit a pull request.

## License

TimeSync is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Contact

If you have any questions or feedback, please contact:

- **Developer:** Leonard Sangoroh
- **Email:** leonardsangoroh@gmail.com
