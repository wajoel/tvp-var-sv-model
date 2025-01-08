function he = hedgeEffectiveness(varUnhedged, varHedged)
    % Compute hedge effectiveness
    he = (varUnhedged - varHedged) ./ varUnhedged;
end
