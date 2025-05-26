# Introducing Ecosphere 🌎

Measure your impact, then watch the planet respond.

![Ecosphere Poster](Screenshots/EcospherePoster.png)

## Available on TestFight

TestFlight Link - https://testflight.apple.com/join/NC2MG1Ub

## Features

- **Lifestyle Questionnaire** - Answer bite‑size questions on transport, diet, energy use and shopping habits
- **Carbon Footprint Score** - Instant calculation in kg CO₂‑e/year, benchmarked against global averages.
- **Interactive 3D Earth** - Featuring a 3D Globe - the main protagonist of the app, that spins powered by SceneKit.
- **Dynamic Backdrop** - Background color shifts from lush green to alarming red to your impact.
- **Actionable Insights** - View a category-by-category breakdown of your footprint—transport, food, energy and more enabling you to take action.

## Technologies under the hood

- **SwiftUI** with Observable view models, custom TimelineView animations, SF Symbols.
- **SceneKit** wrapped in SCNViewRepresentable for seamless SwiftUI integration for the 3D Globe.
- Simple weighted scoring model calibrated with the global coefficients.
- **Core Motion** to make the progress indicator on the questionnaire respond to the device's gyroscope for a more engaging experience.
- **AppStorage** for tiny, secure local saves.

## Built Together 🤝

Crafted by a team of six hailing from China, India, Iran, Italy, and Mexico, and fully localized in English (United States), Italian, and Korean for a truly global reach.

## Installation

1. Clone this repository: `git clone https://github.com/thisisayushs/Ecosphere.git)`
2. Open the project in Xcode.
3. Run the app on a simulator or connected device.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.



