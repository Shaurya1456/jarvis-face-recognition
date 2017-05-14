## Description
Integrate face recognition to <a target="_blank" href="http://domotiquefacile.fr/jarvis/">Jarvis assistant</a> using a PiCamera.

<img src="https://raw.githubusercontent.com/QuentinCG/jarvis-face-recognition/master/presentation.png" width="150">


## Usage

Jarvis will detect people automatically with the PiCamera
```
Jarvis: J'ai détécté Unknown user
Jarvis: J'ai détécté Barack Obama
Jarvis: J'ai détécté Hillary Clinton
...
```


## How to install

1) Take a picture of each of the people you want Jarvis to recognise.

2) Add this plugin to your <a target="_blank" href="http://domotiquefacile.fr/jarvis/">Jarvis assistant</a> (<a target="_blank" href="http://domotiquefacile.fr/jarvis/content/plugins">more info here</a>): ```./jarvis.sh -p https://github.com/QuentinCG/jarvis-face-recognition``` (the installation may take up to 5 hours).

3) Configure the <a target="_blank" href="https://github.com/QuentinCG/jarvis-face-recogntion/blob/master/config.sh">configuration file</a> to match your requirements: You have to specify the name and picture of all users.

7) Enjoy


## Author
[Quentin Comte-Gaz](http://quentin.comte-gaz.com/)


## License

This project is under MIT license. This means you can use it as you want (just don't delete the plugin header).


## Contribute

If you want to add more examples or improve the plugin, just create a pull request with proper commit message and right wrapping.
