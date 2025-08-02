*%% Setup
cd
use "data/penguins.dta", clear

*%% Histogram of Body Mass
twoway (hist body_mass if species == 1, color(orange%40)) ///
  (hist body_mass if species == 2, color(emerald%40)) ///
  (hist body_mass if species == 3, color(purple%40)), ///
   xtitle("Body Mass (g)") ytitle("Frequency") ///
   legend(order(1 "Adelie" 2 "Chinstrap" 3 "Gentoo") pos(1) ring(0) col(1)) ///
   plotregion(style(none)) graphregion(lcolor(none) color(white))

*%% Scatter Plot of Body Mass vs. Flipper Length
cap drop body_mass?
qui separate body_mass, by(species)
twoway scatter body_mass? flipper_len, ///
   mcolor(orange emerald purple) mlab("") ///
   msymbol(O T S) ///
   xtitle("Flipper Length (mm)") ytitle("Body Mass (g)") ///
   legend(order(1 "Adelie" 2 "Chinstrap" 3 "Gentoo") pos(11) ring(0) col(1)) ///
   plotregion(style(none)) graphregion(lcolor(none) color(white))

*%% Regression of Bill Length and Body Mass
qui{
    eststo clear
    eststo: reg bill_len i.species, robust
    eststo: reg bill_len i.species sex, robust
    eststo: reg bill_len i.species sex year, robust
    eststo: reg body_mass i.species, robust
    eststo: reg body_mass i.species sex, robust
    eststo: reg body_mass i.species sex year, robust
}

esttab