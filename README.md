# phodog

## Getting Started

To get started with this project, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone git@github.com:abdullahrs/phodog.git
   ```

   After cloning the repository, navigate to the project directory.

2. **Install dependencies:**

   Run the following command in your project directory to install all the required dependencies:

   ```bash
   flutter pub get
   ```

3. **Run the application:**

   After installing the dependencies, you can launch the app.

   ```bash
   flutter run
   ```

## API Disclaimer

This project utilizes the [Dog CEO's Public API](https://dog.ceo/dog-api/documentation/), a resource for fetching random dog images. It's important to note that while this API is working properly, it lacks pagination and search query parameters, restricting specific queries for dog images.

Furthermore, due to the nature of random image retrieval, occasional 404 errors might occur. These errors are inherent to the randomness of the API responses and do not reflect any issues within the project itself.

Please be aware that this limitation is part of the API's design and not a result of this project's implementation. I have tried to provide the best user experience within the constraints of the current API.

## Usage

This project demonstrates fetching dog breed information from a public API. It showcases a variety of functionalities:

- **Fetching Dog Breed Information:** Utilizes a public API to retrieve dog breed details.
- **Random Breed Image Generation:** Allows users to generate random breed images from their selected dog breed.
- **Cancelable Search Operation:** Provides a search feature for filtering dogs locally, considering API constraints.
- **Native Device Version Retrieval:** Uses platform channels to access device version information from the native side without external plugins.

## Project Details

### Folder Structure

    project_root/
    │
    ├── android/
    │
    ├── assets/
    │   ├── fonts/
    │   │   └── font-family/
    │   ├── images/
    │   │   ├── 1.5x/
    │   │   ├── 2.0x/
    │   │   ├── 3.0x/
    │   │   └── *.png (1x)
    │   └── vectors/
    │
    ├── ios/
    │
    ├── lib/
    │   ├── application/
    │   │   ├── common/
    │   │   │   ├── constants.dart
    │   │   │   └── *.dart
    │   │   ├── config/
    │   │   │   ├── router/
    │   │   │   └── theme/
    │   │   └── features/
    │   │   │   └── feature/
    │   │   │       ├── controller/
    │   │   │       ├── view/
    │   │   │       └── widgets/
    │   │   └── services/
    │   │   │   └── service/
    │   │   │       ├── models/
    │   │   │       └── service.dart
    │   │   └── widgets/
    │   ├── core/
    │   │   ├── extensions/
    │   │   └── utils/
    │   ├── data/
    │   │   ├── common/
    │   │   │   ├── base/
    │   │   │   │   ├── repository/
    │   │   │   │   │   └── base_repository.dart
    │   │   │   │   └── response/
    │   │   │   │       └── base_response.dart
    │   │   │   ├── interceptors/
    │   │   │   └── repository_base_settings.dart
    │   │   └── repository/
    │   │       └── repo-name/
    │   │           ├── dtos/
    │   │           ├── source/
    │   │           │   ├── repo_base_source.dart
    │   │           │   └── repo_repository.dart
    │   ├── main.dart
    │   └── ...
    │
    ├── pubspec.yaml
    └── README.md

### Theme

#### Color Scheme

    Primary : #0055D3
    Secondary : #F2F2F7
    Shadow Gray : rgba(60, 60, 67, 0.6);
    Black : #000000
    White : #FFFFFF

#### Typography

    Font Family: Galano Grotesque

    Font Types : [
        Default/Body : {
            Font Weight : w500
            Font Size : 16
            Line Height : 21.6 (1.35)
            Letter Spacing : 0.01
            Color & use cases : {
                Search unfocused, not found desc : Shadow Gray
                Search focused, Dog search detail descs, setting titles : Black
                Grid item dog name : White
            }
        },
        Default/Caption2 : {
            Font Weight : w600
            Font Size : 11
            Line Height : 14.85 (1.35)
            Letter Spacing : 0.02
            Color & use cases : {
                Home Selected : Dead Blue Eyes
                Home Unselected : Black
            }
        },
        Default/Title3 : {
            Font Weight : w600
            Font Size : 20
            Line Height : 27 (1.35)
            Letter Spacing : 0.01
            Color & use cases : {
                Dog detail title & subtitle :Dead Blue Eyes
            }
        },
        Thin/Headline : {
            Font Weight : w500
            Font Size : 18
            Line Height : 24 (~1.33)
            Letter Spacing : 0.005
            Color & use cases : {
                Dog detail confirm : White
            }
        }
        Default/Headline : {
            Font Weight : w600
            Font Size : 18
            Line Height : 24 (~1.33)
            Letter Spacing : 0.005
            Color & use cases : {
                Not found title : Black
            }
        }
        Thin/Footnote : {
            Font Weight : w500
            Font Size : 13
            Line Height : 18 (~1.385)
            Letter Spacing : 0.01
            Color & use cases : {
                OS version value : Shadow Gray
            }
        }
    ]
