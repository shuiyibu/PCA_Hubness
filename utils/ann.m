t = t0; %initialize temperature
theta = getProbFromSchedule(t);
if randomFloat(0,1) < theta
else
    for
        setChoosingProbability(x,k_occurence.^2);
    end
    normalizeProbabilities();
    DataPoint h = chooseHubProbabilistically(c);
end
t 1?4 updateTemperature(t);