function error = checkFDerror( query, data )
    error = sqrt(sum(abs(query-data).^2));
end

