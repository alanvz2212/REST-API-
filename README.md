# Flutter REST API App

A Flutter application that integrates with a REST API to fetch and display user data.

## Features

- Fetches users from REST API endpoint: `http://localhost:3000/api/users`
- Displays users in a clean, card-based UI
- Pull-to-refresh functionality
- Error handling with retry option
- Loading states
- Responsive design

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── user.dart            # User data model
├── services/
│   └── api_service.dart     # API service for HTTP requests
└── screens/
    └── users_screen.dart    # Main users display screen
```

## Setup Instructions

1. **Prerequisites**
   - Flutter SDK installed
   - Your REST API server running on `http://localhost:3000`

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the App**
   ```bash
   flutter run
   ```

## API Configuration

The app is configured to connect to:
- **Endpoint**: `http://localhost:3000/api/users`
- **Method**: GET
- **Expected Response**: JSON array of user objects

### Expected User Object Structure

```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "phone": "+1234567890",
  "website": "johndoe.com"
}
```

## Important Notes

### For Android Emulator
If you're running the app on an Android emulator, you may need to change the API base URL in `lib/services/api_service.dart`:

```dart
// Change from:
static const String baseUrl = 'http://localhost:3000/api';

// To:
static const String baseUrl = 'http://10.0.2.2:3000/api';
```

This is because Android emulator uses `10.0.2.2` to access the host machine's localhost.

### For iOS Simulator
iOS simulator can use `localhost` directly, so no changes are needed.

## Features Included

1. **Loading State**: Shows a circular progress indicator while fetching data
2. **Error Handling**: Displays error messages with retry functionality
3. **Pull to Refresh**: Users can pull down to refresh the data
4. **Empty State**: Shows appropriate message when no users are found
5. **User Cards**: Each user is displayed in a card with:
   - Avatar with first letter of name
   - Name and email
   - Phone and website (if available)
   - User ID

## Customization

You can easily customize the app by:
- Modifying the User model in `lib/models/user.dart` to match your API response
- Updating the API endpoint in `lib/services/api_service.dart`
- Customizing the UI in `lib/screens/users_screen.dart`

## Troubleshooting

1. **Connection Issues**: Make sure your API server is running on port 3000
2. **CORS Issues**: Ensure your API server allows requests from the Flutter app
3. **Network Permissions**: The app includes internet permission by default in Flutter