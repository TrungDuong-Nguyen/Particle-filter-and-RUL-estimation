# Study the application of stochastic processes to residual life prediction in an imperfect monitoring context.

## Residual life prediction
The residual lifetime, also called remaining useful life (RUL) is defined as the remaining operating time of a system before its failure. Predicting this duration plays an important role in maintenance strategies. 

In practice, residual life prediction is based on monitoring data. In other words, this prediction relies on the measurement of degradation state. But, the values got from measurement are often noisy. The reason is the unavoidable measurement errors or the use of different measurement techniques. 

## Aproach
In this work, I use Gamma process to model the degradation of the system. Besides, I suppose that white Gaussian noise contaminates the measurement of the degradation state. The work comprises two steps.

In the first step, based on the noisy measurement values, I try to find the indicators representing the actual state of the degradation. The idea is to use the particular filter, a Monte Carlo-type numerical simulation method.

After obtaining the indicators mentioned above, the second step is to calculate the residual life by propagating the Gamma process until the degradation level reaches a predetermined failure threshold.

Matlab is the programming language used in all the calculation steps.

<br>

## Notes
A short report written in French is available [here](/Report/Rapport-de-stage.pdf). You can find extractions in English of the report, including  [_Problem Statement_](/Report/Problem-statement.pdf) and [_Conclusion_](/Report/Conclusion.pdf). The list of references are given in folder [Bibliography](/Report/Bibliography/). Also, there is a [17-pages slide](/Presentation-slide/Slide-de-presentation_Soutenance-Master.pdf) presents the outcomes of this study.

Folder [Code-snippets](/Code-snippets/) contains the Matlab implementation of the SIS particle filter.

