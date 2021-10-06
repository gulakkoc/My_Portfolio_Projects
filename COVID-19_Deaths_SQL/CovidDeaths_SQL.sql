


SELECT *
FROM CovidDeaths
ORDER BY 3,4


SELECT *
FROM CovidDeaths
WHERE continent IS  NULL
ORDER BY 3,4

SELECT DISTINCT(CONTINENT)
FROM CovidDeaths

SELECT DISTINCT(LOCATION)
FROM CovidDeaths
WHERE LOCATION LIKE 'Int%'

--SELECT *
--FROM CovidVaccination
--ORDER BY 3,4


--	Select Data that we are going to be using

SELECT location,date,total_cases,new_cases,total_deaths,population 
FROM CovidDeaths
ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths

--Shows likelyhood of dying if you contract coivd in your country

SELECT location,date,total_cases,total_deaths, round(total_deaths/total_cases*100,2) as DeathPercentage
FROM CovidDeaths
WHERE location LIKE '%states%'
ORDER BY 1,2

-- Looking at Total Cases vs Populataion
-- Shows what percentage of population got Covid

SELECT location,date,population,total_cases, round(total_cases/population*100,2) as CovidPercentage
FROM CovidDeaths
--WHERE location LIKE '%states%'
ORDER BY 1,2

-- Looking at Countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) as Highest_Inf , MAX(round(total_cases/population*100,2)) as PercentPopInfected
FROM PortfolioProject_Covid_SQL..CovidDeaths
GROUP BY location, population
ORDER BY 4 DESC;

-- Showing the Countries with Highest Death Count per Population

SELECT location, MAX(CAST(total_deaths AS INT)) as Total_Deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY 2 DESC;


-- BY CONTINENT


-- New Cases Each Day by Continents

SELECT date,continent, SUM(new_cases) AS total_new_cases
FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
GROUP BY date, continent
ORDER BY 1

-- New Cases Each Month by Continent

SELECT continent ,MONTH(DATE) AS month, YEAR(DATE) AS year,  SUM(new_cases) as total_new_cases
FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
GROUP BY continent, MONTH(DATE), YEAR(DATE)
ORDER BY 3,2

-- New Cases Each Year by Continent

SELECT continent ,YEAR(DATE) AS year,  SUM(new_cases) as total_new_cases
FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
GROUP BY continent,YEAR(DATE)
ORDER BY 2 asc, 3 desc

-- Death percentage each day by continents

SELECT date,continent, SUM(new_cases) AS total_new_cases, SUM(CAST(new_deaths as int)) as total_deaths, ROUND(SUM(CAST(new_deaths as int)) /SUM(new_cases)*100,2) AS death_percentage
FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
GROUP BY date, continent
HAVING SUM(new_cases) != 0
ORDER BY 1

-- Death percentage each month by continents

SELECT YEAR(DATE) AS year,MONTH(DATE) AS month, continent, SUM(new_cases) AS total_new_cases, SUM(CAST(new_deaths as int)) as total_deaths, ROUND(SUM(CAST(new_deaths as int)) /SUM(new_cases)*100,2) AS death_percentage
FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
GROUP BY MONTH(DATE), YEAR(DATE), continent
HAVING SUM(new_cases) != 0
ORDER BY 1,2

-- Total Cases by Continent

SELECT continent, SUM(total_cases) AS total_cases
FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
GROUP BY continent
ORDER BY 1

-- Total Cases and Death percentage by Continent

SELECT continent, SUM(total_cases) AS total_cases, SUM(CAST(total_deaths as int)) as total_deaths, ROUND(SUM(CAST(total_deaths as int)) /SUM(total_cases)*100,2) AS death_percentage
FROM CovidDeaths
WHERE CONTINENT IS NOT NULL
GROUP BY continent
--HAVING SUM(new_cases) != 0
--ORDER BY 1,2

-- GLOBAL NUMBERS

-- Total Number of Deaths in the World  

SELECT SUM(cast(total_deaths as bigint)) as TotalNumberofDeaths
FROM CovidDeaths
WHERE Continent IS NOT NULL

-- New Cases Each Day Accross the World

SELECT date, SUM(new_cases) AS total_new_cases, SUM(CAST(new_deaths as int)) as total_deaths, ROUND(SUM(CAST(new_deaths as int)) /SUM(new_cases)*100,2) AS death_percentage
FROM CovidDeaths
WHERE Continent IS NOT NULL
GROUP BY date
HAVING SUM(new_cases) != 0
ORDER BY 1



SELECT date, SUM(new_cases) AS total_new_cases, SUM(CAST(new_deaths as int)) as total_deaths, ROUND(SUM(CAST(new_deaths as int)) /SUM(new_cases)*100,2) AS death_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
--HAVING SUM(new_cases) != 0
ORDER BY 1