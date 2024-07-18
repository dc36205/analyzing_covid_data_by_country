--Select * 
--From PortfolioProject..CovidDeaths
--order by 3, 4 

--Select * 
--From PortfolioProject..CovidVaccination
--order by 3, 4

--Select Data the I going to be using 

--Select Location, date, total_cases, new_cases, total_deaths, population
--From PortfolioProject..CovidDeaths
--order by 1, 2

--Looking at Total Cases vs Total Deaths

--Select Location, date, total_cases, total_deaths   --(total_deaths/total_cases)*100 as DeathPercentage  --convert(decimal(15,3),'total_deaths' / 'total_cases') --*100 as Percent-- (total_deaths/total_cases)*100 as DeathPercentage
--From PortfolioProject..CovidDeaths
--where Location like  '%states%'
--order by 1, 2

-- OJO EN LA BASE DE DATOS: CovidDeaths2_some_clean_perform Se REALIZO EN JupyterNotebook un pequeña limpieza para en las columnas continent, total_deaths, total_cases
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage  --convert(decimal(15,3),'total_deaths' / 'total_cases') --*100 as Percent-- (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths2_some_clean_perform
where Location like  '%states%'
order by 1, 2

--convert(decimal(15,3),'amount' / 'rate')

--convert(decimal(15,3),'total_deaths' / 'total_cases')


--CONVERT(CONVERT(decimal(15,3), sellamount) / CONVERT(decimal(15,3), rateactual))

--CONVERT(CONVERT(decimal(15,3), total_deaths) / CONVERT(decimal(15,3), total_cases))

