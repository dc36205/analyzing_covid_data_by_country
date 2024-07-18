--Queries Part 2

--Global numbers variant without the date
Select SUM(new_cases)  as total_cases, SUM(new_deaths) as total_deaths, (SUM(new_deaths)/ nullif(SUM(new_cases),0))*100 as DeathsPercentage     
From PortfolioProject..CovidDeaths2_some_clean_perform
--where Location like  '%states%'
where continent is not null
--Group by date
order by 1, 2
