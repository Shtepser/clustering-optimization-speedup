# clustering-optimization-speedup
Package for speeding up portfolio optimization using hierarchical clustering

## How to use this package

Load your stocks data into python and pass them into optimize_use_clustering().

For example, optimizing your portfolio by return bound = 120% with speedup using clustering
```python
from clust_opt_turp.speeding_algorithm import optimize_use_clustering
from clust_opt_turp.utils import prepare_data

dt = ... # your strocks pricing data (np.array)
dt = prepare_data(dt)
rets = ... # your stocks returns (np.array)
port = optimize_use_clustering(dt, 1.2, 0.3, 'complete', rets, crit="return_bound")
port # your optimized portfolio (np.array)
```

For more help see next items

## Module clust_opt_turp.speeding_algorithm

```optimize_use_clustering(data, value, t, dist, returns, crit="return_bound")```
* `data`: data on stock assets prices for clustering,
    format: each array row is data on prices changes in period at percents from the beginning of the beginning of the period (e.g. first value in row = 1.0) _(np.array)_
* `t`: threshold value for clustering _(float)_
* `dist`: one of 'single', 'complete', 'average' - clustering distance _(str)_
* `value`: optimization criterion value:
        risk if crit="risk_bound"
        return if crit="return_bound",
        gamma if crit="risk_return" _(float)_
* `returns`: vector of assets returns _(np.array)_
* `crit`: optimization method - by risk bound ("risk_bound"), value bound ("return_bound") or RAPOC ("risk_return") _(str)_

* **return** vector of assets weights in optimal portfolio _(np.array)_

```calc_risk(w, cv)```
* `w`: vector of assets weights in portfolio _(np.array)_
* `cv`: assets covariation matrix _(np.array)_
* **return** portfolio risk _(float)_


```calc_revenue(w, d)```
* `w`: vector of assets weights in portfolio _(np.array)_
* `d`: vector of assets individual returns _(np.array)_
* **return** portfolio revenue (also called portfolio return)  _(float)_

## Module clust_opt_turp.optimizer

```optimize_port(data, value, returns, criterion='return_bound')```
* `data`: data on stock assets prices for clustering, format: each array row is data on prices changes in period at percents from the beginning of the beginning of the period (e.g. first value in row = 1.0) _(np.array)_
* `value`: optimization criterion value:
        risk if criterion="risk_bound"
        return if criterion="return_bound",
        gamma if criterion="risk_return" _(float)_
* `criterion`: optimization method - by risk bound ("risk_bound"), value bound ("return_bound") or RAPOC ("risk_return") _(str)_
* `returns`: vector of assets returns _(np.array)_
* **return** vector of assets weights in optimal portfolio _(np.array)_

## Module clust_opt_turp.utils
```prepare_data(raw_data: np.ndarray)```
* `raw_data`: raw stock data on market prices _(np.array)_
* **return** data prepared for optimizing - first value in row = 1.0 _(np.array)_

```calc_loss(data, return_value, clust_thresold, clust_dist)```

calculates return loss from speeding up portfolio optimization
* `data`: data on stock assets prices for clustering, format: each array row is data on prices changes in period at percents from the beginning of the beginning of the period (e.g. first value in row = 1.0) _(np.array)_
* `return_value`: target portfolio return _(float)_
* `clust_thresold`: clustering thresold _(float)_
* `clust_dist`: clustering distance - one of _'single'_, _'complete'_, _'average'_ _(str)_
* **return** return loss from speeding up portfolio optimization (difference bewteen return of 'clustered' portfolio and 'unclustered portfolio with same risk')
