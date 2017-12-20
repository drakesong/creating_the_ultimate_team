function testUltimate(B, stats, X_ultimate)
%TESTULTIMATE sees how well the Ultimate Team does against others

% Calculate the pihat using predictMatch model created earlier
pihat = mnrval(B, X_ultimate{:,:}, stats);

[m,~] = size(X_ultimate);
Yhat = zeros(m, 1);
for i = 1:m
    [~, Yhat(i)] = max(pihat(i,:));
end

% Tabulate to count the number of wins
result = tabulate(Yhat);

fprintf('DONE\n')
fprintf('  The Ultimate Team will win: %g matches\n',result(1,2))
fprintf('     which is %g%% of matches played\n',result(1,3))

end

