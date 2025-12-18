Select *
From PortfolioProject..CovidDeathsKYP
Order by 3,4

--Select *
--From PortfolioProject..CovidVaccinationsKYP
--Order by 3,4

Select location,date,total_cases,new_cases,total_deaths,population
From PortfolioProject..CovidDeathsKYP
Order by 1,2

--Looking at Total cases vs Total Deaths

Select location,date,total_cases,total_deaths,(total_deaths*100.0/NULLIF(total_cases,0)) as DeathPercentage
From PortfolioProject..CovidDeathsKYP
Where Location like '%Ethiopia%'
Order by 1,2


Select location,date,total_cases,total_deaths,(total_deaths*100.0/NULLIF(total_cases,0)) as DeathPercentage
From PortfolioProject..CovidDeathsKYP
Where Location like '%States%'
Order by 1,2

--Looking at Total Cases Vs Population
--Shows what percentage of population got covid

Select location,date,Population,total_cases,(total_cases*100.0/NULLIF(Population,0)) as DeathPercentage
From PortfolioProject..CovidDeathsKYP
Where Location like '%Ethiopia%'
Order by 1,2

SELECT location,date,population,total_cases,(total_cases * 100.0 / NULLIF(population, 0)) AS PercentPopulationInfected
FROM PortfolioProject..CovidDeathsKYP
WHERE location LIKE '%states%'
ORDER BY PercentPopulationInfected DESC

SELECT location,date,population,total_cases,(total_cases * 100.0 / NULLIF(population, 0)) AS PercentPopulationInfected
FROM PortfolioProject..CovidDeathsKYP
WHERE location LIKE '%Ethiopia%'
ORDER BY PercentPopulationInfected DESC

SELECT location,date,population, total_cases , (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeathsKYP
--Where location like '%States%'
order by 1,2


--Looking at Countries with Highest Infection Rate compared to Population

SELECT location,population, MAX(total_cases) as HighestInfectionCount , MAX(total_cases *100.0/population) as PercentPopulationInfected
FROM PortfolioProject..CovidDeathsKYP
--Where location like '%States%'
Group by location, population
order by PercentPopulationInfected desc


--Showing countries with Highest Death Count per population

SELECT location,MAX(cast(Total_deaths as Int)) as TotalDeathCount
FROM PortfolioProject..CovidDeathsKYP
--Where location like '%States%'
Group by location
order by TotalDeathCount desc

--LET'S BREAK THINGS DOWN BY CONTINENT

SELECT continent,MAX(cast(Total_deaths as Int)) as TotalDeathCount
FROM PortfolioProject..CovidDeathsKYP
--Where location like '%States%'
Where continent is null
Group by continent
order by TotalDeathCount desc


--GLOBAL NUMBERS

SELECT date,SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int)) *100.0/NULLIF(SUM(New_cases), 0) as DeathPercentage
FROM PortfolioProject..CovidDeathsKYP
--Where location like '%States%'
Where continent is not null
Group by date
order by 1,2

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int)) *100.0/NULLIF(SUM(New_cases), 0) as DeathPercentage
FROM PortfolioProject..CovidDeathsKYP
--Where location like '%States%'
Where continent is not null
--Group by date
order by 1,2




 -- Looking at Total Population Vs Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 ,  SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) RollingPeopleVaccinated
 --(RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeathsKYP dea
JOIN PortfolioProject..CovidVaccinationsKYP vac
    ON dea.location = vac.location
    AND dea.date = vac.date
    Where dea.continent is not null
ORDER BY 2,3


--USE CTE

With PopvsVac (Continent, Location, Date, Population,New_Vaccinations,RollingPeopleVaccinated)
as
(

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 ,  SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) RollingPeopleVaccinated
 --(RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeathsKYP dea
JOIN PortfolioProject..CovidVaccinationsKYP vac
    ON dea.location = vac.location
    AND dea.date = vac.date
    Where dea.continent is not null
--Order by 2,3
)
Select *,(RollingPeopleVaccinated/Population)*100 as PercentVaccinated
FROM PopvsVac
ORDER BY 2, 3 

--TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated

Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 ,  SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) RollingPeopleVaccinated
 --(RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeathsKYP dea
JOIN PortfolioProject..CovidVaccinationsKYP vac
    ON dea.location = vac.location
    AND dea.date = vac.date
   -- Where dea.continent is not null
--Order by 2,3

Select *,(RollingPeopleVaccinated/Population)*100 
FROM #PercentPopulationVaccinated


--Creating view to store data for later visualizaations

Create VIEW PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 ,  SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
 --(RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeathsKYP dea
JOIN PortfolioProject..CovidVaccinationsKYP vac
    ON dea.location = vac.location
    AND dea.date = vac.date
   Where dea.continent is not null
--Order by 2,3

Select *
From PercentPopulationVaccinated








