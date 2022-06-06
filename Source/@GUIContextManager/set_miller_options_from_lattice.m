function set_miller_options_from_lattice(app)

millerIndices = crystalSymmetry(app.LatticeTypeDropDown.Value).basicHKL.unique;
for i = 1:length(millerIndices)
    app.MillerIndexDropDown.Items{i} = millerIndices(i).char;
end

end