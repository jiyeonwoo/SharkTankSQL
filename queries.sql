-- Question 1: Average Investment Amount, 0s taken into consideration
SELECT
	ROUND(AVG(M.Investment_Amount), 0) AS MarkCuban_InvestmentAmount,
    ROUND(AVG(R.Investment_Amount), 0) AS RobertHerjavec_InvestmentAmount,
    ROUND(AVG(L.Investment_Amount), 0) AS LoriGreiner_InvestmentAmount,
    ROUND(AVG(K.Investment_Amount), 0) AS KevinOLeary_InvestmentAmount,
    ROUND(AVG(D.Investment_Amount), 0) AS DaymondJohn_InvestmentAmount,
    ROUND(AVG(B.Investment_Amount), 0) AS BarbaraCorcoran_InvestmentAmount
FROM Barbara AS B
JOIN Mark AS M USING(pitch_number)
JOIN Lori AS L USING(pitch_number)
JOIN Robert AS R USING(pitch_number)
JOIN Daymond AS D USING(pitch_number)
JOIN Kevin AS K USING(pitch_number);

-- Average investment amount, zeros removed
SELECT 'Barbara Corcoran' AS Investor, ROUND(AVG(B.Investment_Amount), 0) AS AverageInvestment
FROM Barbara AS B
WHERE B.Investment_Amount != 0
UNION ALL
SELECT 'Mark Cuban' AS Investor, ROUND(AVG(M.Investment_Amount), 0) AS AverageInvestment
FROM Mark AS M
WHERE M.Investment_Amount != 0
UNION ALL
SELECT 'Lori Greiner' AS Investor, ROUND(AVG(L.Investment_Amount),0) AS AverageInvestment
FROM Lori AS L
WHERE L.Investment_Amount != 0
UNION ALL
SELECT 'Robert Herjavec' AS Investor, ROUND(AVG(R.Investment_Amount), 0) AS AverageInvestment
FROM Robert AS R
WHERE R.Investment_Amount != 0
UNION ALL
SELECT 'Daymond John' AS Investor, ROUND(AVG(D.Investment_Amount), 0) AS AverageInvestment
FROM Daymond AS D
WHERE D.Investment_Amount != 0
UNION ALL
SELECT 'Kevin O Leary' AS Investor, ROUND(AVG(K.Investment_Amount), 0) AS AverageInvestment
FROM Kevin AS K
WHERE K.Investment_Amount != 0
ORDER BY AverageInvestment DESC;

-- Question 2: Shark Portfolio Diversity
SELECT * FROM (
    SELECT 
        "Barbara Corcoran" AS Investor, 
        S.industry, 
        COUNT(*) AS TopIndustryCount,
        (SELECT COUNT(DISTINCT S.industry)
         FROM Barbara AS B
         JOIN Episode E USING(pitch_number)
         JOIN deal D USING(pitch_number)
         JOIN startup S USING(startup_name)
         WHERE D.Got_Deal = 1 AND B.Investment_amount > 0) AS IndustryCount
    FROM Barbara AS B
    JOIN Episode E USING(pitch_number)
    JOIN deal D USING(pitch_number)
    JOIN startup S USING(startup_name)
    WHERE D.Got_Deal = 1 AND B.Investment_amount > 0
    GROUP BY S.industry
    ORDER BY TopIndustryCount DESC
    LIMIT 1
) AS BarbaraTopIndustry
UNION ALL
SELECT * FROM (
    SELECT 
        "Mark Cuban" AS Investor, 
        S.industry, 
        COUNT(*) AS TopIndustryCount,
        (SELECT COUNT(DISTINCT S.industry)
         FROM Mark AS M
         JOIN Episode E USING(pitch_number)
         JOIN deal D USING(pitch_number)
         JOIN startup S USING(startup_name)
         WHERE D.Got_Deal = 1 AND M.Investment_amount > 0) AS IndustryCount
    FROM Mark AS M
    JOIN Episode E USING(pitch_number)
    JOIN deal D USING(pitch_number)
    JOIN startup S USING(startup_name)
    WHERE D.Got_Deal = 1 AND M.Investment_amount > 0
    GROUP BY S.industry
    ORDER BY TopIndustryCount DESC
    LIMIT 1
) AS MarkTopIndustry
UNION ALL
SELECT * FROM (
    SELECT 
        "Lori Greiner" AS Investor, 
        S.industry, 
        COUNT(*) AS TopIndustryCount,
        (SELECT COUNT(DISTINCT S.industry)
         FROM Lori AS L
         JOIN Episode E USING(pitch_number)
         JOIN deal D USING(pitch_number)
         JOIN startup S USING(startup_name)
         WHERE D.Got_Deal = 1 AND L.Investment_amount > 0) AS IndustryCount
    FROM Lori AS L
    JOIN Episode E USING(pitch_number)
    JOIN deal D USING(pitch_number)
    JOIN startup S USING(startup_name)
    WHERE D.Got_Deal = 1 AND L.Investment_amount > 0
    GROUP BY S.industry
    ORDER BY TopIndustryCount DESC
    LIMIT 1
) AS LoriTopIndustry
UNION ALL
SELECT * FROM (
    SELECT 
        "Robert Herjavec" AS Investor, 
        S.industry, 
        COUNT(*) AS TopIndustryCount,
        (SELECT COUNT(DISTINCT S.industry)
         FROM Robert AS R
         JOIN Episode E USING(pitch_number)
         JOIN deal D USING(pitch_number)
         JOIN startup S USING(startup_name)
         WHERE D.Got_Deal = 1 AND R.Investment_amount > 0) AS IndustryCount
    FROM Robert AS R
    JOIN Episode E USING(pitch_number)
    JOIN deal D USING(pitch_number)
    JOIN startup S USING(startup_name)
    WHERE D.Got_Deal = 1 AND R.Investment_amount > 0
    GROUP BY S.industry
    ORDER BY TopIndustryCount DESC
    LIMIT 1
) AS RobertTopIndustry
UNION ALL
SELECT * FROM (
    SELECT 
        "Daymond John" AS Investor, 
        S.industry, 
        COUNT(*) AS TopIndustryCount,
        (SELECT COUNT(DISTINCT S.industry)
         FROM Daymond AS DJ
         JOIN Episode E USING(pitch_number)
         JOIN deal D USING(pitch_number)
         JOIN startup S USING(startup_name)
         WHERE D.Got_Deal = 1 AND DJ.Investment_amount > 0) AS IndustryCount
    FROM Daymond AS DJ
    JOIN Episode E USING(pitch_number)
    JOIN deal D USING(pitch_number)
    JOIN startup S USING(startup_name)
    WHERE D.Got_Deal = 1 AND DJ.Investment_amount > 0
    GROUP BY S.industry
    ORDER BY TopIndustryCount DESC
    LIMIT 1
) AS DaymondTopIndustry
UNION ALL
SELECT * FROM (
    SELECT 
        "Kevin O Leary" AS Investor, 
        S.industry, 
        COUNT(*) AS TopIndustryCount,
        (SELECT COUNT(DISTINCT S.industry)
         FROM Kevin AS K
         JOIN Episode E USING(pitch_number)
         JOIN deal D USING(pitch_number)
         JOIN startup S USING(startup_name)
         WHERE D.Got_Deal = 1 AND K.Investment_amount > 0) AS IndustryCount
    FROM Kevin AS K
    JOIN Episode E USING(pitch_number)
    JOIN deal D USING(pitch_number)
    JOIN startup S USING(startup_name)
    WHERE D.Got_Deal = 1 AND K.Investment_amount > 0
    GROUP BY S.industry
    ORDER BY TopIndustryCount DESC
    LIMIT 1
) AS KevinTopIndustry;

-- Question 3: Which States are the most successful?
SELECT S.Pitchers_State AS State, 
    SUM(D.Got_Deal) AS SuccessCount,
    SUM(D.Got_Deal)*100 / COUNT(*) AS SuccessPercent
FROM Startup AS S
JOIN Deal D USING(startup_name)
GROUP BY S.Pitchers_State
HAVING COUNT(*) > 3
ORDER BY SUM(D.Got_Deal) / COUNT(*) DESC;

-- Question 4: Impact of entrepreneur's gender on pitch success
SELECT IFNULL(E.Pitchers_Gender, "Unknown") AS Gender, 
	SUM(D.Got_Deal)*100 / COUNT(*) AS SuccessProportion
FROM entrepreneur AS E
JOIN deal D USING(pitch_number)
GROUP BY E.Pitchers_Gender;

-- Question 5: Which industries produce the pitches with the highest average deal amounts? 
SELECT S.Industry, ROUND(AVG(D.Total_deal_amount), 0) AS AverageDealAmount
FROM startup AS S
JOIN deal D USING(startup_name)
GROUP BY S.Industry
ORDER BY AVG(D.Total_deal_amount) DESC;
SELECT S.Industry, ROUND(AVG(D.Total_deal_amount), 0) AS AverageDealAmount
FROM startup AS S
JOIN deal D USING(startup_name)
WHERE D.Total_deal_amount != 0
GROUP BY S.Industry
ORDER BY AVG(D.Total_deal_amount) DESC;


-- Question 6: Is there a trend in original ask size over time? Observe Episode Sum, Season Averages (Running and Total)
WITH EpSum AS (
	SELECT CONCAT(E.season_number, "-", E.episode_number) AS SeasonEpisode, 
    SUM(D.original_ask_amount) AS EpisodeSum
    FROM Episode AS E
    JOIN deal D USING(pitch_number)
    GROUP BY CONCAT(E.season_number, "-", E.episode_number)
)
SELECT DISTINCT CONCAT(E.season_number, "-", E.episode_number) AS SeasonEpisode,
	ES.EpisodeSum,
    AVG(D.original_ask_amount) OVER (
		PARTITION BY E.season_number
        ORDER BY E.episode_number
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningSeasonAverage,
    AVG(D.original_ask_amount) OVER (
		PARTITION BY E.season_number
    ) AS SeasonAverage
FROM episode AS E
JOIN deal D USING(pitch_number)
JOIN EpSum ES ON ES.SeasonEpisode = CONCAT(E.season_number, "-", E.episode_number);

-- Question 7: What is the average equity percentage requested by entrepreneurs, how does it compare to the final equity percentage?
SELECT DISTINCT E.Season_Number, 
	AVG(D.original_offered_equity) OVER (
		PARTITION BY E.Season_number
	) AS AverageEquity,
	AVG((D.original_offered_equity - D.total_deal_equity)) OVER (
		PARTITION BY E.Season_number
    )AS AverageDifference
FROM deal AS D
JOIN episode E USING(pitch_number)
WHERE D.Got_Deal = 1;

-- Question 8: Impact of equity percentage on likelihood of successful pitch
WITH ED AS (
    SELECT 
        D.pitch_number,
        NTILE(10) OVER (ORDER BY D.original_offered_equity) AS EquityDecile
    FROM deal D
    JOIN startup S USING(startup_name)
)
SELECT EquityDecile,
	SUM(D.Got_Deal) AS SuccessfulPitches,
	ROUND(SUM(D.Got_Deal) / COUNT(*), 2) AS SuccessProportion
FROM ED
JOIN Deal D USING(pitch_number)
GROUP BY EquityDecile
ORDER BY EquityDecile
;
