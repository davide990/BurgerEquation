g = (1-((a.*dt)./dx) .* sqrt(-1) .* sin(dx) + ((a.*dt)./dx).* ((a.*dt)./dx).*...
    (cos(dx)-1) + visc .* (cos(dx)-1)) ./ ...
        (1 + visc - visc.*cos(dx));
        