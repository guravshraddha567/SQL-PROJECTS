select *
from [Portfolio Project ]..[covid deaths]
where continent is not null
order by 3,4

--select *
--from [Portfolio Project ]..CovidVaccinations
--order by 3,4

-- select Dta that we are going to be using

select Location,date,total_cases,new_cases,total_deaths,population
from [Portfolio Project ]..[covid deaths]
order by 1,2

--Looking at Total Cases Vs Total Deaths
--shows likelihood of dying if you contract covid in your country

select Location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from [Portfolio Project ]..[covid deaths]
where location like '%state%'
and continent is not null
order by 1,2

--Looking at Total Cases Vs Population
--Shows what percentage of population got covid

select Location,date,population,total_cases, (total_cases/population)*100 as DeathPercentage
from [Portfolio Project ]..[covid deaths]
--where location like '%state%'
order by 1,2

--Looking at countries with higest Infection Rate compared to Population

select location,population,Max(total_cases)as HighestInfectioncount, Max(total_cases/population)*100 as PercentPopulationInfected
from [Portfolio Project ]..[covid deaths]
--where location like '%state%'
Group by location,population
order by PercentPopulationInfected desc

--Showing Countries with Highest Death Count per population

select location,MAX(Total_deaths)as TotalDeathCount
from [Portfolio Project ]..[covid deaths]
--where location like '%state%'
where continent is not null
Group by location
order by TotalDeathCount desc

--LET'S BREAK THINGS DOWN BY CONTINENT

select location,MAX(cast(Total_deaths as int))as TotalDeathCount
from [Portfolio Project ]..[covid deaths]
--where location like '%state%'
where continent is null
Group by location
order by TotalDeathCount desc

select continent,MAX(Total_deaths)as TotalDeathCount
from [Portfolio Project ]..[covid deaths]
--where location like '%state%'
where continent is not null
Group by continent
order by TotalDeathCount desc

-- showing continets with highest death count per population

select continent,MAX(Total_deaths)as TotalDeathCount
from [Portfolio Project ]..[covid deaths]
--where location like '%state%'
where continent is  not null
Group by continent
order by TotalDeathCount desc

--Global numbers

select SUM(NEW_cases)as total_cases,SUM(cast(new_deaths as int))as total_deaths,SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
from [Portfolio Project ]..[covid deaths]
--where location like '%state%'
where continent is not null
--Group by date
order by 1,2


--Looking at Total Population vs Vaccinations

select [covid deaths].continent,[covid deaths].location,[covid deaths].date,[covid deaths].population,CovidVaccinations.new_vaccinations
,SUM(CONVERT(int,CovidVaccinations.new_vaccinations)) OVER (Partition by [covid deaths].location Order by [covid deaths].location,
[covid deaths].Date) as RollingPeopleVacinated
from [Portfolio Project ]..[covid deaths]
join [Portfolio Project ]..CovidVaccinations
    on [covid deaths].location =CovidVaccinations.location
	and [covid deaths].date=CovidVaccinations.date
where [covid deaths].continent is not null
order by 2,3
  
  
