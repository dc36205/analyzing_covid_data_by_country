--Queries Part 2

-- Working with Vaccination data

--Select *
--From PortfolioProject..CovidVaccination 


--Merging both datasets together:
--Select * --SUM(new_cases)  as total_cases, SUM(new_deaths) as total_deaths, (SUM(new_deaths)/ nullif(SUM(new_cases),0))*100 as DeathsPercentage     
--From PortfolioProject..CovidDeaths2_some_clean_perform as dea
--Join PortfolioProject..CovidVaccination  as vac
--    On dea.location = vac.location
--	and dea.date = vac.date



-- Looking at Total Populaiton vs vaccination
--One way
--Select dea.continent, dea.location,  dea.date,  dea.population, vac.new_vaccinations  --SUM(new_cases)  as total_cases, SUM(new_deaths) as total_deaths, (SUM(new_deaths)/ nullif(SUM(new_cases),0))*100 as DeathsPercentage     
--, SUM(cast (vac.new_vaccinations as int)) OVER (Partition by dea.location)
--From PortfolioProject..CovidDeaths2_some_clean_perform as dea
--Join PortfolioProject..CovidVaccination  as vac
--    On dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
--order by 2, 3

-- Looking at Total Populaiton vs vaccination
--Second way
--Select dea.continent, dea.location,  dea.date,  dea.population, vac.new_vaccinations  --SUM(new_cases)  as total_cases, SUM(new_deaths) as total_deaths, (SUM(new_deaths)/ nullif(SUM(new_cases),0))*100 as DeathsPercentage     
--, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location)
--From PortfolioProject..CovidDeaths2_some_clean_perform as dea
--Join PortfolioProject..CovidVaccination  as vac
--    On dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
--order by 2, 3


----Another way
--Select dea.continent, dea.location,  dea.date,  dea.population, vac.new_vaccinations  --SUM(new_cases)  as total_cases, SUM(new_deaths) as total_deaths, (SUM(new_deaths)/ nullif(SUM(new_cases),0))*100 as DeathsPercentage     
--, SUM(cast (vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, dea.Date) as RollingPeopleVaccinated,
--(RollingPeopleVaccinated/ population)*100   --NEED TO CREATE A CTE
--From PortfolioProject..CovidDeaths2_some_clean_perform as dea  
--Join PortfolioProject..CovidVaccination  as vac
--    On dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
--order by 2, 3


--Another way with a CTE

With PopvsVac (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated) 
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
  SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths2_some_clean_perform dea  
Join PortfolioProject..CovidVaccination vac
    On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--Order by 2, 3
)
select *  
from PopvsVac;

  
