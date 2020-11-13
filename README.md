<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/InvisaMage/papertray">
    <img src="images/logo.png" alt="Logo" width="200" height="200">
  </a>

  <h3 align="center">Papertray</h3>

  <p align="center">
    A collection of scripts written in Bash that manage <a href="https://papermc.io">PaperMC</a>  servers.
  </p>
</p>

----
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]


<!-- TABLE OF CONTENTS -->
## Table of Contents

- [Table of Contents](#table-of-contents)
- [About The Project](#about-the-project)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgements](#acknowledgements)



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://invisamage.com/papertray)

Papertray is a collection of scripts that allows you to easily manage a PaperMC Minecraft server.

Here's why:
* Your time should be focused on creating something amazing. A project that solves a problem and helps others
* You shouldn't be doing the same tasks over and over like creating a README from scratch
* You should element DRY principles to the rest of your life :smile:

Of course, no one template will serve all projects since your needs may be different. So I'll be adding more in the near future. You may also suggest changes by forking this repo and creating a pull request or opening an issue.

A list of commonly used resources that I find helpful are listed in the acknowledgements.



<!-- GETTING STARTED -->
## Getting Started

These steps assume you are running a Debian/Ubuntu based distribution of Linux, however, these steps should be similar for all Linux variations. 
To get a local copy up and running follow these simple example steps.

### Prerequisites

Papertray does not have many dependencies. Java packages are different for many distributions, you may need to lookup the package name for yours.
* jq
* Java
* curl
```sh
sudo apt install jq openjdk-11-jre curl
```

### Installation

1. Clone the repo
```sh
git clone https://github.com/InvisaMage/papertray.git
```
2. Edit the papertray.conf file to suit your needs
3. Make all the scripts executable
```sh
chmod +x *.sh
```
4. Run
```sh
./papertray.sh
```
Papertray will take care of the rest. Please note, on the first run, you will need to accept the Minecraft EULA manually.



<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/InvisaMage/papertray/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Travis - support@invisamage.com

Project Link: [https://github.com/InvisaMage/papertray](https://github.com/InvisaMage/papertray)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* Various bash scripting resources
* My Linux Administration teacher
* [Best README Template](https://github.com/othneildrew/Best-README-Template)
* [Terminalizer](https://github.com/faressoft/terminalizer)



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[stars-shield]: https://img.shields.io/github/stars/InvisaMage/papertray?logo=star
[stars-url]: https://github.com/InvisaMage/papertray/stargazers
[issues-shield]: https://img.shields.io/github/issues/InvisaMage/papertray
[issues-url]: https://github.com/InvisaMage/papertray/issues
[license-shield]: https://img.shields.io/github/license/InvisaMage/papertray
[license-url]: https://github.com/InvisaMage/papertray/blob/main/LICENSE.txt
[product-screenshot]: images/screenshot.gif