# The Bunny Band

I received a scholarship from Apple Inc. to attend WWDC 2017. This is my student scholarship submission. 

The bunny band is an interactive playground that allows users to orchestrate a band to play any music they want, simply by dragging music notes of a particular instrument into slots of that instrument.

## Features and Technologies

For most music lovers out there, the art of music composition is more or less arcane and mysterious. Being able to compose music requires, at the very least, the ability to read sheet music, and probably several years of playing one or more musical instruments. Nonetheless, with the advancement of technology and this playground, anyone with any level of musical knowledge can enjoy the process of making their own music.

The bunny band is an interactive playground that allows users to orchestrate a band to play any music they want, simply by dragging music notes of a particular instrument into slots of that instrument. The playground allows user to play 4 different instruments, including trombone, saxophone, drum, and violin. To allow the user to compose as they wish, the sound file of each notes was recorded individually in GarageBand. This presented a challenge for playing the composed songs, since at any given time, there could be four sound files playing simultaneously. A natural solution to play note files sequentially would be the AVQueuePlayer, which works perfectly when playing the sequential notes of a single instrument. However, when attempting to use four AVQueuePlayers to play the notes of all instruments together, synchronization became a problem. To resolve this issue, a song is divided into multiple time fragments, with each fragment having the length of one sound file. I created a custom class “Composed Notes”, which stores four notes, one for each instrument. The composed notes are linked to each other, and can be traversed in a linked list fashion, playing all notes in one time frame before moving to the next.

With numerous audio and image files, loading time also became an issue. As a result, I created a “SharedAudioPlayer” singleton that is used to play sound when a user taps on a note. Of course, there are some sound files that needs to be played simultaneously and cannot use the shared audio player. However, this cut down on at least half of the loading time, giving the user a better experience. In addition, the major loading process is done on a background thread, allowing the user to watch a fun animated scene on the splash screen rather than staring at a blank screen waiting for the program to load.

After the program loads, an introductory page is presented to the user, followed by a demo performance of what can be achieve in the playground, then by another page prompting them to start their own project. All these pages are custom UIViews, and communicate with each other through multiple protocols.

I have envisioned this playground to grow into a fun yet educational app for children to learn about music, thus animation is also a major component.  Both UIView animation and core animation are used to provide an interesting and engaging experience for users of all ages.


