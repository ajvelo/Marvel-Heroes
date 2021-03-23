[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

<br />
<p align="center">
  <a href="https://github.com/ajvelo/Marvel-Heroes">
  <img src="images/heroes.png" alt="Heroes" width="200" height="400">
  </a>

  <h3 align="center">Marvel Heroes</h3>

  <p align="center">
  An iOS application that allows you to view all the Marvel heroes and the comics they star in.
    <br />
    <a href="https://github.com/ajvelo/Marvel-Heroes"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/ajvelo/Marvel-Heroes">View Demo</a>
    ·
    <a href="https://github.com/ajvelo/Marvel-Heroes/issues">Report Bug</a>
    ·
    <a href="https://github.com/ajvelo/Marvel-Heroes/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

An iOS application that allows you to view all the Marvel heroes and the comics they star in.


### Built With

This project is built with Xcode 12.4.


<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/ajvelo/Marvel-Heroes.git
   ```
2. Sign up for a developer account at https://developer.marvel.com/ to get your API keys
3. Within the project, create a Constants file:
   ```
   struct Constants {
    static let PRIVATE_KEY = "<your-private-key>"
    static let PUBLIC_KEY = "<your-public-key>"
    static let TS = String(Date().timeIntervalSince1970)
    }
    ```

4. Install pods
   ```sh
   pod install
   ```
5. Run the project!

## Usage

<p align="center">
<img src="images/heroes.png" alt="Heroes" width="200" height="400">
&nbsp; &nbsp; &nbsp; &nbsp;
<img src="images/comics.png" alt="Comics" width="200" height="400">
</p>


<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/ajvelo/Marvel-Heroes/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



[contributors-shield]: https://img.shields.io/github/contributors/ajvelo/Marvel-Heroes.svg?style=for-the-badge
[contributors-url]: https://github.com/ajvelo/Marvel-Heroes/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/ajvelo/Marvel-Heroes.svg?style=for-the-badge
[forks-url]: https://github.com/ajvelo/Marvel-Heroes/network/members
[stars-shield]: https://img.shields.io/github/stars/ajvelo/Marvel-Heroes.svg?style=for-the-badge
[stars-url]: https://github.com/ajvelo/Marvel-Heroes/stargazers
[issues-shield]: https://img.shields.io/github/issues/ajvelo/Marvel-Heroes.svg?style=for-the-badge
[issues-url]: https://github.com/ajvelo/Marvel-Heroes/issues
