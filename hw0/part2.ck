["-","-"," ",".",".","-"," ",".",".","."," ",".","."," ","-",".","-","."," ",".",".",".",".",".",".","."," ",".",".","-","-","-",
" ",".",".","-","-","-"," ","-","-","-","-","-"] @=> string morse[]; // morse code for "music 220"

SinOsc foo => NRev r => dac;
.2 => foo.gain;
0.1 => r.mix;

fun void dot() {
    440 => foo.freq;
    200::ms => now;
    0 => foo.gain;
    40::ms => now;
    .2 => foo.gain;
}

fun void dash() {
    [523.25, 587.33, 659.25] @=> float sounds[];
    sounds[Math.random2(0,2)] => foo.freq;
    440::ms => now;
    0 => foo.gain;
    40::ms => now;
    .2 => foo.gain;
}

fun void space() {
    0 => foo.gain;
    480::ms => now;
    .2 => foo.gain;
}

fun void bass() {
    [ 110.0, 130.81, 164.81, 130.81, 164.81, 220.0] @=> float notes[];
    TriOsc bar => NRev c => dac;
    0.3 => c.mix;
    0.2 => bar.gain;
    for ( 0 => int i; i < 6; i++ ) {
        notes[i] => bar.freq;
        2.88::second => now;
    }
}

while ( true ) {
    spork ~ bass();
    for ( 0 => int i; i< morse.cap(); i++ ) {
        if (morse[i] == "-") dash();
        if (morse[i] == ".") dot();
        if (morse[i] == " ") space();
    }
}


