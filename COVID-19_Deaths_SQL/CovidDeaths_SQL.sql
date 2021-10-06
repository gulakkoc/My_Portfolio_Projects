


SELECT *
FROM CovidDeaths
ORDER BY 3,4

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

SELECT location,population,total_cases, round(total_cases/population*100,2) as CovidPercentage
FROM CovidDeaths
ORDER BY 1,2


