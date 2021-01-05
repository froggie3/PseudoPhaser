<Cabbage>
form size(880, 240), caption("PseudoPhaser"), pluginID("plu1")
groupbox bounds(0, 0, 880, 240), imgfile("..\src\PseudoPhaserTemplate.svg"), identchannel("groupbox") colour(35, 35, 35, 0) fontcolour(160, 160, 160, 0) outlinecolour(160, 160, 160, 0) 

// Title
groupbox fontcolour(255, 255, 255, 255), , 255) colour(94, 94, 94, 255) corners(0) outlinecolour(0, 0, 0, 0) bounds(10, 20, 480, 53)
label bounds(646, 34, 214, 10) text("built by Yokkin / v1.0.1 (2 January 2021)") align("right") colour(255, 255, 255, 0) fontcolour(255, 255, 255, 255)

// Band 1
groupbox bounds(20, 70, 637, 148) outlinecolour(160, 160, 160, 0) visible(0)
rslider bounds(40, 102, 100, 100) range(1, 256, 16, 0.5, 1)  textcolour(255, 255, 255, 255) text("Order") colour(212, 212, 212, 255) fontcolour(255, 255, 255, 255)  markercolour(10, 10, 10, 255)  trackercolour(204, 204, 204, 0)    textboxoutlinecolour(255, 255, 255, 0)    valuetextbox(1) trackerinsideradius(0.8) outlinecolour(0, 0, 0, 56) channel("Order") identchannel("OrderDest1") 
rslider bounds(138, 102, 100, 100) range(20, 5000, 100, 0.5, 1)  textcolour(255, 255, 255, 255) text("Frequency (Hz)") colour(212, 212, 212, 255) fontcolour(255, 255, 255, 255)  markercolour(10, 10, 10, 255)  trackercolour(204, 204, 204, 0)    textboxoutlinecolour(255, 255, 255, 0)    valuetextbox(1) trackerinsideradius(0.8) outlinecolour(0, 0, 0, 56) channel("Frequency") 
checkbox bounds(260, 106, 42, 12)  colour:1(255, 255, 255, 255)  fontcolour:0(96, 96, 96, 255) fontcolour:1(255, 255, 255, 255) corners(1) channel("UseAlternativeFilter")  text("ALT")
rslider bounds(242, 124, 66, 78) range(0, 1, 0.3, 1, 0.01)  textcolour(255, 255, 255, 255) text("Q") colour(212, 212, 212, 255)     trackercolour(255, 255, 255, 0)           channel("Q")    fontcolour(255, 255, 255, 255) valuetextbox(1) textboxoutlinecolour(128, 128, 128, 0) outlinecolour(58, 58, 58, 56) markercolour(0, 0, 0, 255)

// Band 2
rslider bounds(346, 100, 100, 100) range(1, 256, 16, 0.5, 1)  textcolour(255, 255, 255, 255) text("Order") colour(212, 212, 212, 255) fontcolour(255, 255, 255, 255)  markercolour(10, 10, 10, 255)  trackercolour(204, 204, 204, 0)    textboxoutlinecolour(255, 255, 255, 0)    valuetextbox(1) trackerinsideradius(0.8) outlinecolour(0, 0, 0, 56) channel("Band2Order") identchannel("OrderDest1") 
checkbox bounds(572, 84, 66, 12)  colour:1(255, 255, 255, 255) fontcolour:1(255, 255, 255, 255) fontcolour:0(96, 96, 96, 255)  corners(0) text("ENABLE") channel("Band2Enable") 
rslider bounds(446, 100, 100, 100) range(20, 5000, 3000, 0.5, 1)  textcolour(255, 255, 255, 255) text("Frequency (Hz)") colour(212, 212, 212, 255) fontcolour(255, 255, 255, 255)  markercolour(10, 10, 10, 255)  trackercolour(204, 204, 204, 0)    textboxoutlinecolour(255, 255, 255, 0)    valuetextbox(1) trackerinsideradius(0.8) outlinecolour(0, 0, 0, 56) channel("Band2Frequency") 
rslider bounds(550, 122, 66, 78) range(0, 1, 0.3, 1, 0.01)  textcolour(255, 255, 255, 255) text("Q") colour(212, 212, 212, 255)     trackercolour(255, 255, 255, 0)           channel("Band2Q")    fontcolour(255, 255, 255, 255) valuetextbox(1) textboxoutlinecolour(128, 128, 128, 0) outlinecolour(58, 58, 58, 56) markercolour(0, 0, 0, 255)
checkbox bounds(572, 106, 42, 12)  colour:1(255, 255, 255, 255)  fontcolour:0(96, 96, 96, 255) fontcolour:1(255, 255, 255, 255) corners(1) channel("Band2UseAlternativeFilter")  text("ALT") 
checkbox bounds(644, 188, 69, 12)  colour:1(255, 255, 255, 255) text("CENTER") fontcolour:0(96, 96, 96, 255) fontcolour:1(255, 255, 255, 255) corners(1)  channel("RemoveDCOffset") value(1)

// Right
vslider bounds(720, 86, 62, 130) range(0, 100, 100, 1, 1)   text("Mix (%)") channel("Mix") trackercolour(0, 0, 0, 128) valuetextbox(1) fontcolour(255, 255, 255, 255) textcolour(255, 255, 255, 255)
vslider bounds(792, 86, 62, 130) range(-144, 0, 0, 4, 0.1)  channel("Level") text("Level (dB)") trackercolour(0, 0, 0, 128) valuetextbox(1) fontcolour(255, 255, 255, 255) textcolour(255, 255, 255, 255)


</Cabbage>
<CsoundSynthesizer>

<CsOptions>
-n -d
</CsOptions>

<CsInstruments>
ksmps = 64
nchnls = 2
0dbfs = 1

instr PseudoPhaser
    kBand1Enable         chnget "Band1Enable"
    kBand2Enable         chnget "Band2Enable"
    gkBand1Freq          chnget "Frequency"
    gkBand1Q             chnget "Q"
    gkBand2Freq          chnget "Band2Frequency"
    gkBand2Q             chnget "Band2Q"
    kBand1Order          chnget "Order"
    kBand2Order          chnget "Band2Order"
    gkMix                chnget "Mix"
    gkLevel              chnget "Level"
    kBand1FiltAlt        chnget "UseAlternativeFilter"
    kBand2FiltAlt        chnget "Band2UseAlternativeFilter"
    kRemoveDC            chnget "RemoveDCOffset"
    
    asigL, asigR ins
    
    kPortTime linseg 0, 0.01, 0.03
    
    
    kBand1Freq portk gkBand1Freq, kPortTime
    kBand2Freq portk gkBand2Freq, kPortTime
    kBand1Q portk gkBand1Q, kPortTime
    kBand2Q portk gkBand2Q, kPortTime
    kMix portk gkMix, kPortTime
    
    gkLevel = db(gkLevel)	// dB
    kLevel portk gkLevel, kPortTime
    
    kMix *= 0.01 // give float value instead of percent 


if kBand1FiltAlt = 0 then // when kBand1FiltAlt is turned OFF
    kSwitch changed	kBand1Order, kBand1FiltAlt, kRemoveDC, kBand2Enable // kSwitch detects when kBand1Order is changed
	
    if kSwitch = 1 then 
        reinit UPDATE1 // make all the audio signals up-to-date
    endif
	
    UPDATE1:
    aphsL phaser1 asigL, kBand1Freq, kBand1Order, 0
    aphsR phaser1 asigR, kBand1Freq, kBand1Order, 0
    rireturn
endif
  
if kBand1FiltAlt = 1 then    // when kBand1FiltAlt is turned ON
    kSwitch	changed	kBand1Order, kBand1FiltAlt, kRemoveDC, kBand2Enable
	
    if kSwitch = 1 then 
        reinit UPDATE2
    endif
	
    UPDATE2:
    aphsL phaser2 asigL, kBand1Freq, kBand1Q, kBand1Order, 2, 1, 0   // asigL, kBand1Freq, kBand1Q, kBand1Order, kmode, ksep, kfeedback
    aphsR phaser2 asigR, kBand1Freq, kBand1Q, kBand1Order, 2, 1, 0
    rireturn
    
endif

if kBand2Enable = 1 then    // Band 2 is Enable
    if kBand2FiltAlt = 0 then
        kSwitch changed	kBand2Order, kBand2FiltAlt, kRemoveDC, kBand2Enable
	
        if kSwitch = 1 then 
            reinit UPDATE3 // make all the audio signals up-to-date
        endif
	
        UPDATE3:
        aphsL phaser1 aphsL, kBand2Freq, kBand2Order, 0
        aphsR phaser1 aphsR, kBand2Freq, kBand2Order, 0
        rireturn
    endif
    
    if kBand2FiltAlt = 1 then 
        kSwitch	changed	kBand2Order, kBand2FiltAlt, kRemoveDC, kBand2Enable
	
        if kSwitch = 1 then 
            reinit UPDATE4
        endif
	
        UPDATE4:
        aphsL phaser2 aphsL, kBand2Freq, kBand2Q, kBand2Order, 2, 1, 0
        aphsR phaser2 aphsR, kBand2Freq, kBand2Q, kBand2Order, 2, 1, 0
        rireturn
    
    endif
endif

if kRemoveDC = 1 then
    aphsL clfilt aphsL, 20, 1, 4, 1 // 'phaser2' now and then puts DC-offset which damages your speaker
    aphsR clfilt aphsR, 20, 1, 4, 1
endif

    amixL ntrpol asigL, aphsL, kMix // calculates weighted mean value between asig & aphs 
    amixR ntrpol asigR, aphsR, kMix
    outs amixL * kLevel, amixR * kLevel
    
endin
rireturn
</CsInstruments>  
<CsScore>
i "PseudoPhaser" 0 [60*60*24*7]
</CsScore>
</CsoundSynthesizer>