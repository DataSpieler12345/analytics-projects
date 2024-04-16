select * from df_youtubestaats

-- YOUTUBE TOP PLAYERS
-- Top continets in the YouTube space; Uploads, views, earnings, Subs and num_of_youtubers
SELECT
    CASE
        WHEN Country IN ('Algeria','Angola','Benin','Botswana','Burkina Faso','Burundi','Cabo Verde','Cameroon','Central African Republic',
            'Chad','Comoros','Congo, Dem. Rep', 'Congo, Rep.','Cote d''Ivoire','Djibouti','Egypt','Equatorial Guinea','Eritrea',
            'Eswatini (formerly Swaziland)','Ethiopia','Gabon','Gambia','Ghana','Guinea','Guinea-Bissau','Kenya', 'Lesotho',
            'Liberia','Libya','Madagascar','Malawi','Mali','Mauritania','Mauritius','Morocco','Mozambique','Namibia',
            'Niger','Nigeria','Rwanda','Sao Tome and Principe','Senegal','Seychelles','Sierra Leone','Somalia','South Africa',
            'South Sudan','Sudan','Tanzania','Togo','Tunisia','Uganda','Zambia','Zimbabwe') THEN 'Africa'

        WHEN Country IN ('Albania','Andorra', 'Armenia','Austria','Azerbaijan','Belarus','Belgium','Bosnia and Herzegovina',
            'Bulgaria','Croatia','Cyprus','Czechia','Denmark','Estonia','Finland','France','Georgia','Germany',
            'Greece','Hungary','Iceland','Ireland','Italy','Kazakhstan','Kosovo','Latvia','Liechtenstein','Lithuania',
            'Luxembourg','Malta','Moldova','Monaco','Montenegro','Netherlands','Macedonia, FYR','Norway','Poland','Portugal',
            'Romania','Russia','San Marino','Serbia','Slovakia','Slovenia','Spain','Sweden','Switzerland','Turkey',
            'Ukraine','United Kingdom','Vatican City') THEN 'Europe'

        WHEN Country IN ('Afghanistan','Armenia','Azerbaijan','Bahrain','Bangladesh', 'Bhutan','Brunei','Cambodia','China','Cyprus',
            'Georgia','India','Indonesia','Iran','Iraq','Israel','Japan','Jordan','Kazakhstan','Kuwait','Kyrgyzstan','Laos',
            'Lebanon','Malaysia','Maldives','Mongolia','Myanmar','Nepal','North Korea','Oman','Pakistan','Palestine','Philippines',
            'Qatar','Russia','Saudi Arabia','Singapore','South Korea','Sri Lanka','Syria','Taiwan','Tajikistan','Thailand',
            'Timor-Leste','Turkey','Turkmenistan','United Arab Emirates','Uzbekistan','Vietnam','Yemen') THEN 'Asia'

        WHEN Country IN ('Antigua and Barbuda','Bahamas','Barbados','Belize','Canada','Costa Rica','Cuba','Dominica',
            'Dominican Republic','El Salvador','Grenada','Guatemala','Haiti','Honduras','Jamaica','Mexico',
            'Nicaragua','Panama','Saint Vincent and the Grenadines','United States') THEN 'North_America'

        WHEN Country IN ('Argentina','Bolivia','Brazil','Chile','Colombia','Ecuador','Guyana','Paraguay','Peru','Suriname',
            'Uruguay','Venezuela') THEN 'South_America'

        WHEN Country IN ('Australia','Fiji','Kiribati','Marshall Islands','Micronesia','Nauru','New Zealand','Palau',
            'Papua New Guinea','Samoa','Solomon Islands','Tonga','Tuvalu','Vanuatu') THEN 'Australia_and_Oceania'
    END AS continents,
    SUM(subscribers) AS total_subscribers,
    SUM(uploads) AS total_uploads,
    SUM([video views]) AS total_views,
    ROUND(SUM(highest_yearly_earnings), 0) AS total_year_earnings,
    COUNT(Youtuber) AS num_of_youtubers
FROM df_youtubestaats
GROUP BY
    CASE
        WHEN Country IN ('Algeria','Angola','Benin','Botswana','Burkina Faso','Burundi','Cabo Verde','Cameroon','Central African Republic',
            'Chad','Comoros','Congo, Dem. Rep', 'Congo, Rep.','Cote d''Ivoire','Djibouti','Egypt','Equatorial Guinea','Eritrea',
            'Eswatini (formerly Swaziland)','Ethiopia','Gabon','Gambia','Ghana','Guinea','Guinea-Bissau','Kenya', 'Lesotho',
            'Liberia','Libya','Madagascar','Malawi','Mali','Mauritania','Mauritius','Morocco','Mozambique','Namibia',
            'Niger','Nigeria','Rwanda','Sao Tome and Principe','Senegal','Seychelles','Sierra Leone','Somalia','South Africa',
            'South Sudan','Sudan','Tanzania','Togo','Tunisia','Uganda','Zambia','Zimbabwe') THEN 'Africa'

        WHEN Country IN ('Albania','Andorra', 'Armenia','Austria','Azerbaijan','Belarus','Belgium','Bosnia and Herzegovina',
            'Bulgaria','Croatia','Cyprus','Czechia','Denmark','Estonia','Finland','France','Georgia','Germany',
            'Greece','Hungary','Iceland','Ireland','Italy','Kazakhstan','Kosovo','Latvia','Liechtenstein','Lithuania',
            'Luxembourg','Malta','Moldova','Monaco','Montenegro','Netherlands','Macedonia, FYR','Norway','Poland','Portugal',
            'Romania','Russia','San Marino','Serbia','Slovakia','Slovenia','Spain','Sweden','Switzerland','Turkey',
            'Ukraine','United Kingdom','Vatican City') THEN 'Europe'

        WHEN Country IN ('Afghanistan','Armenia','Azerbaijan','Bahrain','Bangladesh', 'Bhutan','Brunei','Cambodia','China','Cyprus',
            'Georgia','India','Indonesia','Iran','Iraq','Israel','Japan','Jordan','Kazakhstan','Kuwait','Kyrgyzstan','Laos',
            'Lebanon','Malaysia','Maldives','Mongolia','Myanmar','Nepal','North Korea','Oman','Pakistan','Palestine','Philippines',
            'Qatar','Russia','Saudi Arabia','Singapore','South Korea','Sri Lanka','Syria','Taiwan','Tajikistan','Thailand',
            'Timor-Leste','Turkey','Turkmenistan','United Arab Emirates','Uzbekistan','Vietnam','Yemen') THEN 'Asia'

        WHEN Country IN ('Antigua and Barbuda','Bahamas','Barbados','Belize','Canada','Costa Rica','Cuba','Dominica',
            'Dominican Republic','El Salvador','Grenada','Guatemala','Haiti','Honduras','Jamaica','Mexico',
            'Nicaragua','Panama','Saint Vincent and the Grenadines','United States') THEN 'North_America'

        WHEN Country IN ('Argentina','Bolivia','Brazil','Chile','Colombia','Ecuador','Guyana','Paraguay','Peru','Suriname',
            'Uruguay','Venezuela') THEN 'South_America'

        WHEN Country IN ('Australia','Fiji','Kiribati','Marshall Islands','Micronesia','Nauru','New Zealand','Palau',
            'Papua New Guinea','Samoa','Solomon Islands','Tonga','Tuvalu','Vanuatu') THEN 'Australia_and_Oceania'
    END
ORDER BY 5 DESC;


-- pct of pay per continent 
With pct_pay as(
    SELECT
        CASE
            WHEN Country IN ('Algeria','Angola','Benin','Botswana','Burkina Faso','Burundi','Cabo Verde','Cameroon','Central African Republic',
                'Chad','Comoros','Congo, Dem. Rep', 'Congo, Rep.','Cote d''Ivoire','Djibouti','Egypt','Equatorial Guinea','Eritrea',
                'Eswatini (formerly Swaziland)','Ethiopia','Gabon','Gambia','Ghana','Guinea','Guinea-Bissau','Kenya', 'Lesotho',
                'Liberia','Libya','Madagascar','Malawi','Mali','Mauritania','Mauritius','Morocco','Mozambique','Namibia',
                'Niger','Nigeria','Rwanda','Sao Tome and Principe','Senegal','Seychelles','Sierra Leone','Somalia','South Africa',
                'South Sudan','Sudan','Tanzania','Togo','Tunisia','Uganda','Zambia','Zimbabwe') THEN 'Africa'

            WHEN Country IN ('Albania','Andorra', 'Armenia','Austria','Azerbaijan','Belarus','Belgium','Bosnia and Herzegovina',
                'Bulgaria','Croatia','Cyprus','Czechia','Denmark','Estonia','Finland','France','Georgia','Germany',
                'Greece','Hungary','Iceland','Ireland','Italy','Kazakhstan','Kosovo','Latvia','Liechtenstein','Lithuania',
                'Luxembourg','Malta','Moldova','Monaco','Montenegro','Netherlands','Macedonia, FYR','Norway','Poland','Portugal',
                'Romania','Russia','San Marino','Serbia','Slovakia','Slovenia','Spain','Sweden','Switzerland','Turkey',
                'Ukraine','United Kingdom','Vatican City') THEN 'Europe'

            WHEN Country IN ('Afghanistan','Armenia','Azerbaijan','Bahrain','Bangladesh', 'Bhutan','Brunei','Cambodia','China','Cyprus',
                'Georgia','India','Indonesia','Iran','Iraq','Israel','Japan','Jordan','Kazakhstan','Kuwait','Kyrgyzstan','Laos',
                'Lebanon','Malaysia','Maldives','Mongolia','Myanmar','Nepal','North Korea','Oman','Pakistan','Palestine','Philippines',
                'Qatar','Russia','Saudi Arabia','Singapore','South Korea','Sri Lanka','Syria','Taiwan','Tajikistan','Thailand',
                'Timor-Leste','Turkey','Turkmenistan','United Arab Emirates','Uzbekistan','Vietnam','Yemen') THEN 'Asia'

            WHEN Country IN ('Antigua and Barbuda','Bahamas','Barbados','Belize','Canada','Costa Rica','Cuba','Dominica',
                'Dominican Republic','El Salvador','Grenada','Guatemala','Haiti','Honduras','Jamaica','Mexico',
                'Nicaragua','Panama','Saint Vincent and the Grenadines','United States') THEN 'North_America'

            WHEN Country IN ('Argentina','Bolivia','Brazil','Chile','Colombia','Ecuador','Guyana','Paraguay','Peru','Suriname',
                'Uruguay','Venezuela') THEN 'South_America'

            WHEN Country IN ('Australia','Fiji','Kiribati','Marshall Islands','Micronesia','Nauru','New Zealand','Palau',
                'Papua New Guinea','Samoa','Solomon Islands','Tonga','Tuvalu','Vanuatu') THEN 'Australia_and_Oceania'
        END AS continents,

        ROUND(SUM(highest_yearly_earnings) / COUNT(DISTINCT Country), 0) AS total_pcp
    FROM df_youtubestaats
    GROUP BY
        CASE
            WHEN Country IN ('Algeria','Angola','Benin','Botswana','Burkina Faso','Burundi','Cabo Verde','Cameroon','Central African Republic',
                'Chad','Comoros','Congo, Dem. Rep', 'Congo, Rep.','Cote d''Ivoire','Djibouti','Egypt','Equatorial Guinea','Eritrea',
                'Eswatini (formerly Swaziland)','Ethiopia','Gabon','Gambia','Ghana','Guinea','Guinea-Bissau','Kenya', 'Lesotho',
                'Liberia','Libya','Madagascar','Malawi','Mali','Mauritania','Mauritius','Morocco','Mozambique','Namibia',
                'Niger','Nigeria','Rwanda','Sao Tome and Principe','Senegal','Seychelles','Sierra Leone','Somalia','South Africa',
                'South Sudan','Sudan','Tanzania','Togo','Tunisia','Uganda','Zambia','Zimbabwe') THEN 'Africa'

            WHEN Country IN ('Albania','Andorra', 'Armenia','Austria','Azerbaijan','Belarus','Belgium','Bosnia and Herzegovina',
                'Bulgaria','Croatia','Cyprus','Czechia','Denmark','Estonia','Finland','France','Georgia','Germany',
                'Greece','Hungary','Iceland','Ireland','Italy','Kazakhstan','Kosovo','Latvia','Liechtenstein','Lithuania',
                'Luxembourg','Malta','Moldova','Monaco','Montenegro','Netherlands','Macedonia, FYR','Norway','Poland','Portugal',
                'Romania','Russia','San Marino','Serbia','Slovakia','Slovenia','Spain','Sweden','Switzerland','Turkey',
                'Ukraine','United Kingdom','Vatican City') THEN 'Europe'

            WHEN Country IN ('Afghanistan','Armenia','Azerbaijan','Bahrain','Bangladesh', 'Bhutan','Brunei','Cambodia','China','Cyprus',
                'Georgia','India','Indonesia','Iran','Iraq','Israel','Japan','Jordan','Kazakhstan','Kuwait','Kyrgyzstan','Laos',
                'Lebanon','Malaysia','Maldives','Mongolia','Myanmar','Nepal','North Korea','Oman','Pakistan','Palestine','Philippines',
                'Qatar','Russia','Saudi Arabia','Singapore','South Korea','Sri Lanka','Syria','Taiwan','Tajikistan','Thailand',
                'Timor-Leste','Turkey','Turkmenistan','United Arab Emirates','Uzbekistan','Vietnam','Yemen') THEN 'Asia'

            WHEN Country IN ('Antigua and Barbuda','Bahamas','Barbados','Belize','Canada','Costa Rica','Cuba','Dominica',
                'Dominican Republic','El Salvador','Grenada','Guatemala','Haiti','Honduras','Jamaica','Mexico',
                'Nicaragua','Panama','Saint Vincent and the Grenadines','United States') THEN 'North_America'

            WHEN Country IN ('Argentina','Bolivia','Brazil','Chile','Colombia','Ecuador','Guyana','Paraguay','Peru','Suriname',
                'Uruguay','Venezuela') THEN 'South_America'

            WHEN Country IN ('Australia','Fiji','Kiribati','Marshall Islands','Micronesia','Nauru','New Zealand','Palau',
                'Papua New Guinea','Samoa','Solomon Islands','Tonga','Tuvalu','Vanuatu') THEN 'Australia_and_Oceania'
        END
)

select 
    sum(total_pcp) as total_pcp,

    ROUND(1.0 * sum(case when continents = 'Africa' then total_pcp else 0 end) / nullif(sum(total_pcp), 0) * 100,2) as pcp_africa,
    ROUND(1.0 * sum(case when continents = 'Asia' then total_pcp else 0 end) / nullif(sum(total_pcp), 0) * 100,2) as pcp_asia,
    ROUND(1.0 * sum(case when continents = 'North_America' then total_pcp else 0 end) / nullif(sum(total_pcp), 0) * 100,2) as pcp_north_america,
    ROUND(1.0 * sum(case when continents = 'Europe' then total_pcp else 0 end) / nullif(sum(total_pcp), 0) * 100,2) as pcp_europe,
    ROUND(1.0 * sum(case when continents = 'South_America' then total_pcp else 0 end) / nullif(sum(total_pcp), 0) * 100,2) as pcp_south_america,
    ROUND(1.0 * sum(case when continents = 'Australia_and_Oceania' then total_pcp else 0 end) / nullif(sum(total_pcp), 0) * 100,2) as pcp_australia_oceania
from 
    pct_pay

-- Top 8 Countries, pct pay 

WITH country_pct AS (
    SELECT
        Country,
        ROUND(SUM(highest_yearly_earnings), 0) AS total_earnings
    FROM df_youtubestaats
    GROUP BY Country
)

SELECT
    SUM(total_earnings) AS total_earnings,
    ROUND(1.0 * SUM(CASE WHEN Country = 'United States' THEN total_earnings ELSE 0 END) / NULLIF(SUM(total_earnings), 0) * 100, 2) AS pct_us,
    ROUND(1.0 * SUM(CASE WHEN Country = 'India' THEN total_earnings ELSE 0 END) / NULLIF(SUM(total_earnings), 0) * 100, 2) AS pct_india,
    ROUND(1.0 * SUM(CASE WHEN Country = 'Brazil' THEN total_earnings ELSE 0 END) / NULLIF(SUM(total_earnings), 0) * 100, 2) AS pct_brazil,
    ROUND(1.0 * SUM(CASE WHEN Country = 'South Korea' THEN total_earnings ELSE 0 END) / NULLIF(SUM(total_earnings), 0) * 100, 2) AS pct_southKorea,
    ROUND(1.0 * SUM(CASE WHEN Country = 'United Kingdom' THEN total_earnings ELSE 0 END) / NULLIF(SUM(total_earnings), 0) * 100, 2) AS pct_uk,
    ROUND(1.0 * SUM(CASE WHEN Country = 'Pakistan' THEN total_earnings ELSE 0 END) / NULLIF(SUM(total_earnings), 0) * 100, 2) AS pct_pakistan,
    ROUND(1.0 * SUM(CASE WHEN Country = 'Argentina' THEN total_earnings ELSE 0 END) / NULLIF(SUM(total_earnings), 0) * 100, 2) AS pct_argentina,
    ROUND(1.0 * SUM(CASE WHEN Country = 'Russia' THEN total_earnings ELSE 0 END) / NULLIF(SUM(total_earnings), 0) * 100, 2) AS pct_russia
FROM country_pct;


-- Top 8 Channel Types, sum views

SELECT TOP 8
    channel_type,
    SUM([video views]) AS total_views
FROM df_youtubestaats
GROUP BY channel_type
ORDER BY total_views DESC;
