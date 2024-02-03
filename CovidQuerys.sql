SELECT TOP (1000) [location]
    ,[date]
    ,[population]
    ,[total_cases]
    ,[new_cases]
    ,[new_cases_smoothed]
    ,[total_deaths]
FROM [CovidProject].[dbo].[CovidDead]
Order by 1, 2

-- Porcentagem de óbitos
SELECT [location], date
      ,ROUND(([total_deaths]/[total_cases])*100, 2) as deathPercentage
      
FROM [CovidProject].[dbo].[CovidDead]
WHERE [total_deaths] is not null 
AND location = 'Brazil'
Order by date

  -- Países com maior taxa de infecção
SELECT [location], max(Round((total_cases/ [population])*100,2)) as percentInfection
FROM [CovidProject].[dbo].[CovidDead]
group by location
Order by 2 desc

-- Países com maior taxa de óbito
SELECT [location], max(cast([total_deaths] as int)) as quantDeaths, max(Round(([total_deaths]/ [population])*100,2)) as percentDeath
FROM [CovidProject].[dbo].[CovidDead]
where continent is not null
group by location
Order by 3 desc

-- Dividindo por continente
SELECT location, max(cast([total_deaths] as int)) as quantDeaths, max(Round(([total_deaths]/ [population])*100,2)) as percentDeath
FROM [CovidProject].[dbo].[CovidDead]
where continent is null
group by location
Order by 3 desc

-- Dados globais
SELECT [location]
      ,max([total_cases]) as caseCount
      ,max([total_deaths]) as deathCount
	 , round(max([total_cases])/max([total_deaths])*100, 2) as deathPercentage
FROM [CovidProject].[dbo].[CovidDead]
where location = 'World'
group by location


  -- Vacinados x População
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, vac.total_vaccinations
from  CovidProject..CovidVaccines vac
join CovidProject..CovidDead dea
on dea.date = vac.date and dea.location = vac.location
--where dea.continent = 'Europe' and vac.new_vaccinations = 8236
order by 1,2,3