<Cabbage>
form size(880, 240), caption("PseudoPhaser"), pluginId("PsPh") guiRefresh(10)

// Loads background image
groupbox bounds(0, 0, 880, 240), imgFile("./svg/PseudoPhaserTemplate.svg"), identChannel("groupbox") colour(35, 35, 35, 0) fontColour(160, 160, 160, 0) outlineColour(160, 160, 160, 0)

// GUI settings for band 1
rslider bounds(60, 134, 64, 64) range(1, 256, 16, 0.5, 1)  textColour(255, 255, 255, 255)  colour(212, 212, 212, 255) fontColour(255, 255, 255, 255)  markerColour(10, 10, 10, 255)  trackerColour(204, 204, 204, 0)  outlineColour(0, 0, 0, 255) channel("Order") identChannel("OrderDest1") trackerInsideRadius(0.8)
rslider bounds(158, 134, 64, 64) range(20, 5000, 100, 0.5, 1)  textColour(255, 255, 255, 255)  colour(212, 212, 212, 255) fontColour(255, 255, 255, 255)  markerColour(10, 10, 10, 255)  trackerColour(204, 204, 204, 0) trackerInsideRadius(0.8) outlineColour(0, 0, 0, 56) channel("Frequency")
checkbox bounds(260, 108, 42, 12)  colour:1(255, 255, 255, 255)  fontColour:0(96, 96, 96, 255) fontColour:1(255, 255, 255, 255) corners(1) channel("UseAlternativeFilter")  text("ALT")
rslider bounds(256, 150, 48, 48) range(0, 1, 0.3, 1, 0.01)  textColour(255, 255, 255, 255)  colour(212, 212, 212, 255)trackerColour(255, 255, 255, 0)channel("Q")fontColour(255, 255, 255, 255)   outlineColour(58, 58, 58, 56) markerColour(0, 0, 0, 255)

// GUI settings for band 2
rslider bounds(368, 134, 64, 64) range(1, 256, 16, 0.5, 1)  textColour(255, 255, 255, 255)  colour(212, 212, 212, 255) fontColour(255, 255, 255, 255)  markerColour(10, 10, 10, 255)  trackerColour(204, 204, 204, 0) trackerInsideRadius(0.8) outlineColour(0, 0, 0, 56) channel("Band2Order") identChannel("OrderDest1")
checkbox bounds(572, 84, 66, 12)  colour:1(255, 255, 255, 255) fontColour:1(255, 255, 255, 255) fontColour:0(96, 96, 96, 255)  corners(0) text("ENABLE") channel("Band2Enable")
rslider bounds(464, 134, 64, 64) range(20, 5000, 3000, 0.5, 1)  textColour(255, 255, 255, 255)  colour(212, 212, 212, 255) fontColour(255, 255, 255, 255)  markerColour(10, 10, 10, 255)  trackerColour(204, 204, 204, 0) trackerInsideRadius(0.8) outlineColour(0, 0, 0, 56) channel("Band2Frequency")
rslider bounds(560, 150, 48, 48) range(0, 1, 0.3, 1, 0.01)  textColour(255, 255, 255, 255)  colour(212, 212, 212, 255)trackerColour(255, 255, 255, 0)channel("Band2Q")fontColour(255, 255, 255, 255)   outlineColour(58, 58, 58, 56) markerColour(0, 0, 0, 255)
checkbox bounds(572, 108, 42, 12)  colour:1(255, 255, 255, 255)  fontColour:0(96, 96, 96, 255) fontColour:1(255, 255, 255, 255) corners(1) channel("Band2UseAlternativeFilter")  text("ALT")
checkbox bounds(644, 188, 69, 12)  colour:1(255, 255, 255, 255) text("CENTER") fontColour:0(96, 96, 96, 255) fontColour:1(255, 255, 255, 255) corners(1)  channel("RemoveDCOffset") value(1)

// GUI settings for right part
vslider bounds(720, 105, 62, 111) range(0, 100, 100, 1, 1) channel("Mix") trackerColour(0, 0, 0, 128) fontColour(255, 255, 255, 255) textColour(255, 255, 255, 255)
vslider bounds(792, 104, 62, 111) range(-144, 0, 0, 4, 0.1) channel("Level") trackerColour(0, 0, 0, 128) fontColour(255, 255, 255, 255) textColour(255, 255, 255, 255)


</Cabbage>
<CsoundSynthesizer>

<CsOptions>
    -n -d
</CsOptions>

<CsInstruments>
nchnls = 2

instr 1

kBand1Enable chnget "Band1Enable"
kBand2Enable chnget "Band2Enable"
gkBand1Freq chnget "Frequency"
gkBand1Q chnget "Q"
gkBand2Freq chnget "Band2Frequency"
gkBand2Q chnget "Band2Q"
kBand1Order chnget "Order"
kBand2Order chnget "Band2Order"
gkMix chnget "Mix"
gkLevel chnget "Level"
kBand1FiltAlt chnget "UseAlternativeFilter"
kBand2FiltAlt chnget "Band2UseAlternativeFilter"
kRemoveDC chnget "RemoveDCOffset"

asigL, asigR ins

kPortTime linseg 0, 0.01, 0.03

kBand1Freq portk gkBand1Freq, kPortTime
kBand2Freq portk gkBand2Freq, kPortTime
kBand1Q portk gkBand1Q, kPortTime
kBand2Q portk gkBand2Q, kPortTime
kMix portk gkMix, kPortTime

// Convert linear scale to dB scale
gkLevel = db(gkLevel)
kLevel portk gkLevel, kPortTime

// Give float value instead of percent
kMix *= 0.01

// ktrig detects when kBand1Order is changed
ktrig changed kBand1Order, kBand1FiltAlt
ktrig2 changed kBand2Order, kBand2FiltAlt

if (ktrig == 1) then
    reinit UPDATE1
endif

if (ktrig2 == 1 && kBand2Enable == 1) then
    reinit UPDATE3
endif

UPDATE1:
    // whether to use alternative filter
    if (kBand1FiltAlt == 0) then
        aphsL phaser1 asigL, kBand1Freq, kBand1Order, 0
        aphsR phaser1 asigR, kBand1Freq, kBand1Order, 0
    elseif (kBand1FiltAlt == 1) then
        // asigL, kBand1Freq, kBand1Q, kBand1Order, kmode, ksep, kfeedback
        aphsL phaser2 asigL, kBand1Freq, kBand1Q, kBand1Order, 2, 1, 0
        aphsR phaser2 asigR, kBand1Freq, kBand1Q, kBand1Order, 2, 1, 0
    endif

UPDATE3:
    if (kBand2Enable == 1) then
        if (kBand2FiltAlt == 0) then
            aphsL phaser1 aphsL, kBand2Freq, kBand2Order, 0
            aphsR phaser1 aphsR, kBand2Freq, kBand2Order, 0
        elseif (kBand2FiltAlt == 1) then
            aphsL phaser2 aphsL, kBand2Freq, kBand2Q, kBand2Order, 2, 1, 0
            aphsR phaser2 aphsR, kBand2Freq, kBand2Q, kBand2Order, 2, 1, 0
        endif
    endif

// remove DC-offset when alternative filter is enabled
if (kRemoveDC == 1) then
    aphsL clfilt aphsL, 20, 1, 4, 1
    aphsR clfilt aphsR, 20, 1, 4, 1
endif

// calculates weighted mean value between asig & aphs
amixL ntrpol asigL, aphsL, kMix
amixR ntrpol asigR, aphsR, kMix

outs amixL * kLevel, amixR * kLevel

endin
</CsInstruments>
<CsScore>
    i1 0 4294967295
</CsScore>
</CsoundSynthesizer>