# GameDeals iOS App

A native iOS application that displays video game deals from the CheapShark API, allowing users to browse and filter deals by price range.

## Features

- Browse video game deals from Steam and other digital storefronts
- Filter deals by price range using interactive sliders
- Infinite scrolling to load more deals as you browse
- View detailed information about each deal
- Direct links to purchase pages

## Architecture

The app follows the MVC (Model-View-Controller) design pattern:

### Models
- `Deal`: Represents a game deal with properties like title, sale price, normal price, etc.
- `DealStore`: Handles API communication and data fetching

### Views
- `DealTableViewCell`: Custom cell for displaying deal information in a table view
- Storyboard layouts for main screens and detail views

### Controllers
- `DealsViewController`: Manages the main deals list, including filtering and pagination
- `DealDetailViewController`: Displays detailed information about a selected deal

## API Integration

The app uses the CheapShark API to fetch game deals. No API key is required for basic functionality.

- Base URL: `https://www.cheapshark.com/api/1.0/deals`
- Parameters:
  - `storeID`: Filter by store (default: 1 for Steam)
  - `pageNumber`: For pagination
  - `lowerPrice`: Minimum price filter
  - `upperPrice`: Maximum price filter

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.0+

## Installation

1. Clone the repository
2. Open `GameDeals.xcodeproj` in Xcode
3. Build and run the application on your simulator or device

## Usage

- The main screen displays a list of game deals
- Use the sliders at the top to adjust the price range filters
- Scroll down to automatically load more deals
- Tap on a deal to view more details
- Use the detail view to access the store page
