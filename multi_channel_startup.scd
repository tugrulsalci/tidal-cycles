// MULTICHANNEL ROUTING SETUP
(
    s.options.numBuffers = 1024 * 6;
    s.options.memSize = 8192 * 16;
    s.options.maxNodes = 1024 * 64;

s.options.numOutputBusChannels = 12;

    s.waitForBoot{

 ~dirt = SuperDirt(2,s);
 ~dirt.loadSoundFiles;
 // wait until load is done
 s.sync;

 //configure your bus routes
 ~dirt.start(57120, [0,2,4,6,8,10]);
	(
			~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
			~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
			~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
			~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
		);
 s.meter;
 s.latency = 0.3;
   }
)