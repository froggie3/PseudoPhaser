<Cabbage> bounds(0, 0, 0, 0)
form size(450, 200), caption("PseudoPhaser"), pluginID("plu1"), colour(55, 55, 55, 255) 
groupbox bounds(12, 12, 420, 42),  , colour(94, 94, 94, 255) fontcolour(255, 255, 255, 255) outlinecolour(0, 0, 0, 0) outlinethickness(2) corners(0)
label bounds(24, 20, 185, 26), text("PseudoPhaser"), fontcolour(233, 233, 233, 255) align("left") corners(0)
label bounds(216, 20, 204, 12) text("Just a simple allpass filter") align("right") fontcolour(255, 255, 255, 255), corners(0) 
groupbox fontcolour(255, 255, 255, 255), , 255) colour(94, 94, 94, 255) corners(0) outlinecolour(0, 0, 0, 0) bounds(10, 20, 480, 53)
groupbox bounds(12, 62, 420, 130) fontcolour(233, 233, 233, 255) colour(96, 96, 96, 255) outlinecolour(255, 255, 255, 0) corners(0)

rslider bounds(18, 66, 100, 100) range(1, 256, 16, 0.5, 1)  textcolour(255, 255, 255, 255) text("Order") colour(212, 212, 212, 255) fontcolour(255, 255, 255, 255)  markercolour(10, 10, 10, 255)  trackercolour(204, 204, 204, 0)    textboxoutlinecolour(255, 255, 255, 0)    valuetextbox(1) trackerinsideradius(0.8) outlinecolour(0, 0, 0, 56) channel("Order") identchannel("OrderDest1") 
label bounds(30, 140, 12, 10) text("1") fontcolour(255, 255, 255, 255) corners(0) 
label bounds(90, 140, 20, 10) text("256") fontcolour(255, 255, 255, 255) corners(0) 

rslider bounds(116, 66, 100, 100) range(20, 5000, 100, 0.5, 1)  textcolour(255, 255, 255, 255) text("Frequency (Hz)") colour(212, 212, 212, 255) fontcolour(255, 255, 255, 255)  markercolour(10, 10, 10, 255)  trackercolour(204, 204, 204, 0)    textboxoutlinecolour(255, 255, 255, 0)    valuetextbox(1) trackerinsideradius(0.8) outlinecolour(0, 0, 0, 56) channel("Frequency") 
label bounds(124, 140, 12, 10) text("20") fontcolour(255, 255, 255, 255) corners(0) 
label bounds(192, 140, 20, 10) text("5k") fontcolour(255, 255, 255, 255) corners(0) 

rslider bounds(220, 88, 66, 78) range(0, 1, 0.3, 1, 0.01)  textcolour(255, 255, 255, 255) text("Q") colour(212, 212, 212, 255)     trackercolour(255, 255, 255, 0)           channel("Q")    fontcolour(255, 255, 255, 255) valuetextbox(1) textboxoutlinecolour(128, 128, 128, 0) outlinecolour(58, 58, 58, 56) markercolour(0, 0, 0, 255)
label bounds(222, 140, 12, 10) text("0") fontcolour(255, 255, 255, 255) corners(0) 
label bounds(270, 140, 20, 10) text("1.0") fontcolour(255, 255, 255, 255) corners(0) 
nslider bounds(290, 90, 62, 40) range(0, 100, 100, 1, 1)  textcolour(255, 255, 255, 255) text("Mix (%)") colour(255, 255, 255, 255)     trackercolour(192, 192, 192, 255)           channel("Mix")  velocity(0)  fontcolour(29, 29, 29, 255)
nslider bounds(360, 90, 62, 40) range(-18, 0, 0, 1, 0.1)  textcolour(255, 255, 255, 255) text("Level (dB)") colour(255, 255, 255, 255) fontcolour(26, 26, 26, 255)  markercolour(0, 0, 0, 255)  trackercolour(204, 204, 204, 0)    textboxoutlinecolour(255, 255, 255, 0)      outlinecolour(0, 0, 0, 56) channel("Level")  velocity(0) 


label bounds(216, 36, 203, 10) text("built by Yokkin / v1.0 (20 December 2020)") align("right") colour(255, 255, 255, 0) fontcolour(255, 255, 255, 255)

checkbox bounds(310, 170, 42, 12)  colour:1(255, 255, 255, 255)  fontcolour:0(156, 156, 156, 255) fontcolour:1(255, 255, 255, 255) corners(1) channel("UseAlternativeFilter")  text("ALT")
checkbox bounds(358, 170, 69, 12)  colour:1(255, 255, 255, 255) text("CENTER") fontcolour:0(156, 156, 156, 255) fontcolour:1(255, 255, 255, 255) corners(1) value(1) channel("RemoveDCOffset")


</Cabbage>
<CsoundSynthesizer>

<CsOptions>
-n -d
</CsOptions>

<CsInstruments>
ksmps = 64
nchnls = 2
0dbfs = 1

instr 1
    kfreq           chnget "Frequency"
    kQ              chnget "Q"
    kord            chnget "Order"
    kmix            chnget "Mix"
    klevel          chnget "Level"
    kfalt           chnget "UseAlternativeFilter"
    kDC             chnget "RemoveDCOffset"
    
    asigL, asigR ins
    
    kporttime linseg 0, 0.01, 0.03
    kfreq portk kfreq, kporttime
    
    klevel = db(klevel)	// dB
    
    kfeedback=0
    ksep=1
    
    kfeedback = kfeedback * 0.01
    
    kmix = kmix * 0.01
    
    kmode=2 // Power, another one is kmode = 1
    
if kfalt != 1 then // when kfalt is turned OFF
	kSwitch changed	kord, kfalt, kDC // kSwitch detects when kord is changed
	
	if kSwitch = 1 then 
		reinit UPDATE2 // make all the audio signals up-to-date
	endif
	
	UPDATE2:
    aphsL phaser1 asigL, kfreq, kord, kfeedback
    aphsR phaser1 asigR, kfreq, kord, kfeedback
    rireturn
    
else     // when kfalt is turned ON
	kSwitch	changed	kord, kmode, kfalt, kDC
	
	if kSwitch = 1 then 
		reinit UPDATE1
	endif
	
	UPDATE1:
    aphsL phaser2 asigL, kfreq, kQ, kord, kmode, ksep, kfeedback
    aphsR phaser2 asigR, kfreq, kQ, kord, kmode, ksep, kfeedback
    rireturn
    
endif

if kDC == 1 then
    aphsL clfilt aphsL, 20, 1, 4, 1 // 'phaser2' now and then puts DC-offset which damages your speaker
    aphsR clfilt aphsR, 20, 1, 4, 1
    
endif

    amixL ntrpol asigL, aphsL, kmix // calculates weighted mean value between asig & aphs. then 
    amixR ntrpol asigR, aphsR, kmix
    outs amixL * klevel, amixR * klevel
    
endin

</CsInstruments>  
<CsScore>
i 1 0 [3600*24*7]
</CsScore>
</CsoundSynthesizer>