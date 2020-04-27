// algorave mastering, roughly according to
// https://mccormick.cx/news/entries/heuristic-for-algorave-mastering
(
~busses = ~dirt.orbits.collect { |each|
	var bus = Bus.audio(~dirt.server, ~dirt.numChannels);
	each.outBus = bus;
	bus
}
);

(
Ndef(\x, {
	var level = 1;
	var distortion = 1;
	var reverbFeedback = 0.1;
	var all = ~busses.collect { |each| InBus.ar(each, each.numChannels) };
	var mix = all.sum { |x|
		var d = { 0.01.rand } ! x.size;
		DelayN.ar(x, d, d)
	};
	var loop = LocalIn.ar(~dirt.numChannels);
	5.do { loop = AllpassL.ar(loop, 0.15, { ExpRand(0.03, 0.15) } ! 2, 3) };
	mix = loop * reverbFeedback + mix;
	mix = LeakDC.ar(mix);
	LocalOut.ar(mix);
	mix = Compander.ar(mix, mix, 0.3, slopeBelow:1, slopeAbove:0.5, clampTime:0.01, relaxTime:0.01);
	mix = (mix * distortion).tanh * (level / distortion.max(1));
	mix
}).play;
);



/*
cleaning up when you're done:
*/
(
Ndef(\x).clear;
~busses.do { |x| x.free };
~dirt.orbits.do { |x| x.outBus = 0 };
);



