<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gann Calculator</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/chart.js@3.7.0/dist/chart.min.css" rel="stylesheet">
    <style>
        .calculator-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
        }
        .result-section {
            margin-top: 2rem;
            padding: 1rem;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            background-color: #f8f9fa;
        }
        .significant-date {
            color: #dc3545;
            font-weight: bold;
        }
        .loading {
            display: none;
            text-align: center;
            margin: 1rem 0;
        }
        .gann-wheel {
            width: 400px;
            height: 400px;
            margin: 2rem auto;
            position: relative;
            border-radius: 50%;
            border: 2px solid #333;
        }
        .wheel-marker {
            position: absolute;
            width: 10px;
            height: 10px;
            background: red;
            border-radius: 50%;
            transform: translate(-50%, -50%);
        }
        .chart-container {
            margin: 2rem 0;
            height: 400px;
        }
        .planetary-indicator {
            display: inline-block;
            padding: 0.5rem 1rem;
            margin: 0.5rem;
            border-radius: 4px;
            font-weight: bold;
        }
        .tab-content {
            padding: 2rem 0;
        }
    </style>
</head>
<body>
    <div class="container calculator-container">
        <h1 class="text-center mb-4">Gann Mathematical Calculator</h1>
        
        <!-- Download Button -->
        <div class="text-center mb-4">
            <a href="${pageContext.request.contextPath}/download" class="btn btn-success">
                <i class="bi bi-download"></i> Download Calculator Package
            </a>
        </div>
        
        <!-- Navigation Tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" data-bs-toggle="tab" href="#singleDate">Single Date Analysis</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#projection">Price/Time Projection</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#pattern">Pattern Analysis</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#prediction">Future Predictions</a>
            </li>
        </ul>

        <!-- Tab Content -->
        <div class="tab-content">
            <!-- Single Date Analysis -->
            <div id="singleDate" class="tab-pane active">
                <form id="singleDateForm">
                    <div class="mb-3">
                        <label for="dateTime" class="form-label">Select Date and Time</label>
                        <input type="datetime-local" class="form-control" id="dateTime" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Calculate</button>
                </form>
                <div id="singleDateResults" class="result-section" style="display: none;">
                    <div class="row">
                        <div class="col-md-6">
                            <h5>Basic Calculations</h5>
                            <div id="basicResults"></div>
                        </div>
                        <div class="col-md-6">
                            <h5>Advanced Analysis</h5>
                            <div id="advancedResults"></div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <h5>Gann Wheel</h5>
                            <div id="gannWheel" class="gann-wheel"></div>
                        </div>
                        <div class="col-md-6">
                            <h5>Harmonic Chart</h5>
                            <canvas id="harmonicChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Price/Time Projection -->
            <div id="projection" class="tab-pane fade">
                <form id="projectionForm">
                    <div class="row">
                        <div class="col-md-6">
                            <label for="startDate" class="form-label">Start Date and Time</label>
                            <input type="datetime-local" class="form-control" id="startDate" required>
                        </div>
                        <div class="col-md-6">
                            <label for="endDate" class="form-label">End Date and Time</label>
                            <input type="datetime-local" class="form-control" id="endDate" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary mt-3">Calculate Projection</button>
                </form>
                <div id="projectionResults" class="result-section" style="display: none;">
                    <div class="row">
                        <div class="col-md-6">
                            <h5>Projection Details</h5>
                            <div id="projectionDetails"></div>
                        </div>
                        <div class="col-md-6">
                            <h5>Market Cycles</h5>
                            <div id="marketCycles"></div>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="projectionChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Pattern Analysis -->
            <div id="pattern" class="tab-pane fade">
                <form id="patternForm">
                    <div id="dateInputs">
                        <div class="mb-3">
                            <label class="form-label">Date 1</label>
                            <input type="datetime-local" class="form-control date-input" required>
                        </div>
                    </div>
                    <button type="button" class="btn btn-secondary mb-3" id="addDate">Add Another Date</button>
                    <button type="submit" class="btn btn-primary">Analyze Pattern</button>
                </form>
                <div id="patternResults" class="result-section" style="display: none;">
                    <div class="row">
                        <div class="col-md-6">
                            <h5>Pattern Analysis</h5>
                            <div id="patternDetails"></div>
                        </div>
                        <div class="col-md-6">
                            <h5>Cycle Analysis</h5>
                            <div id="cycleDetails"></div>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="patternChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Future Predictions -->
            <div id="prediction" class="tab-pane fade">
                <form id="predictionForm">
                    <div class="row">
                        <div class="col-md-6">
                            <label for="baseDate" class="form-label">Base Date and Time</label>
                            <input type="datetime-local" class="form-control" id="baseDate" required>
                        </div>
                        <div class="col-md-6">
                            <label for="months" class="form-label">Months to Predict</label>
                            <input type="number" class="form-control" id="months" value="12" min="1" max="60">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary mt-3">Generate Predictions</button>
                </form>
                <div id="predictionResults" class="result-section" style="display: none;">
                    <h5>Significant Future Dates</h5>
                    <div id="predictions"></div>
                    <div class="chart-container">
                        <canvas id="predictionChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="loading">
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.0/dist/chart.min.js"></script>
    <script>
        $(document).ready(function() {
            // Single Date Calculator
            $('#singleDateForm').on('submit', function(e) {
                e.preventDefault();
                const dateTime = $('#dateTime').val();
                
                $('.loading').show();
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/gann/calculate',
                    method: 'POST',
                    data: { dateTime: dateTime },
                    success: function(response) {
                        if (response.success) {
                            const calc = response.calculation;
                            
                            // Basic Results
                            let basicHtml = `
                                <p><strong>Square of 9:</strong> ${calc.squareOf9Value.toFixed(2)}</p>
                                <p><strong>Harmonic Value:</strong> ${calc.harmonicValue.toFixed(2)}°</p>
                                <p><strong>Natural Square:</strong> ${calc.naturalSquareValue.toFixed(2)}</p>
                                <p><strong>Numerology Number:</strong> ${calc.numerologyNumber}</p>
                                <p><strong>Planetary Influence:</strong> ${calc.planetaryInfluence}</p>
                            `;
                            
                            // Advanced Results
                            let advancedHtml = `
                                <p><strong>Time Factor:</strong> ${calc.timeFactor.toFixed(2)}</p>
                                <p><strong>Seasonal Pattern:</strong> ${calc.seasonalPattern}</p>
                                <p><strong>Master Numbers:</strong> ${calc.masterNumbers.join(', ')}</p>
                            `;
                            
                            if (calc.criticalDates && calc.criticalDates.length > 0) {
                                advancedHtml += `
                                    <p><strong>Upcoming Critical Dates:</strong></p>
                                    <ul>
                                        ${calc.criticalDates.slice(0, 5).map(date => 
                                            `<li>${new Date(date).toLocaleDateString()}</li>`
                                        ).join('')}
                                    </ul>
                                `;
                            }
                            
                            $('#basicResults').html(basicHtml);
                            $('#advancedResults').html(advancedHtml);
                            
                            // Update Gann Wheel
                            updateGannWheel(calc);
                            
                            // Update Harmonic Chart
                            updateHarmonicChart(calc);
                            
                            $('#singleDateResults').show();
                        } else {
                            alert('Error: ' + response.error);
                        }
                    },
                    error: function() {
                        alert('Error occurred while calculating');
                    },
                    complete: function() {
                        $('.loading').hide();
                    }
                });
            });

            // Price/Time Projection Calculator
            $('#projectionForm').on('submit', function(e) {
                e.preventDefault();
                const startDate = $('#startDate').val();
                const endDate = $('#endDate').val();
                
                $('.loading').show();
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/gann/projection',
                    method: 'POST',
                    data: {
                        startDate: startDate,
                        endDate: endDate
                    },
                    success: function(response) {
                        if (response.success) {
                            const proj = response.projection;
                            
                            // Display projection details
                            let detailsHtml = `
                                <p><strong>Price/Time Angle:</strong> ${proj.priceTimeAngle.toFixed(2)}°</p>
                                <h6>Trend Reversal Points:</h6>
                                <ul>
                                    ${proj.reversalPoints.map(point => 
                                        `<li>${point.toFixed(2)}</li>`
                                    ).join('')}
                                </ul>
                            `;
                            
                            // Display market cycles
                            let cyclesHtml = `
                                <h6>Start Date Cycles:</h6>
                                <ul>
                                    ${Object.entries(proj.startCycles).map(([key, value]) =>
                                        `<li><strong>${key}:</strong> ${value.toFixed(2)}</li>`
                                    ).join('')}
                                </ul>
                                <h6>End Date Cycles:</h6>
                                <ul>
                                    ${Object.entries(proj.endCycles).map(([key, value]) =>
                                        `<li><strong>${key}:</strong> ${value.toFixed(2)}</li>`
                                    ).join('')}
                                </ul>
                            `;
                            
                            $('#projectionDetails').html(detailsHtml);
                            $('#marketCycles').html(cyclesHtml);
                            
                            // Update projection chart
                            updateProjectionChart(proj);
                            
                            $('#projectionResults').show();
                        } else {
                            alert('Error: ' + response.error);
                        }
                    },
                    error: function() {
                        alert('Error occurred while calculating projection');
                    },
                    complete: function() {
                        $('.loading').hide();
                    }
                });
            });

            // Pattern Analysis
            $('#addDate').click(function() {
                const count = $('.date-input').length + 1;
                const html = `
                    <div class="mb-3">
                        <label class="form-label">Date ${count}</label>
                        <input type="datetime-local" class="form-control date-input" required>
                    </div>
                `;
                $('#dateInputs').append(html);
            });

            $('#patternForm').on('submit', function(e) {
                e.preventDefault();
                const dates = $('.date-input').map(function() {
                    return $(this).val();
                }).get();
                
                $('.loading').show();
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/gann/pattern',
                    method: 'POST',
                    data: { dates: dates },
                    success: function(response) {
                        if (response.success) {
                            const analysis = response.analysis;
                            
                            // Display pattern details
                            let patternHtml = `
                                <h6>Common Master Numbers:</h6>
                                <p>${analysis.commonMasterNumbers.join(', ') || 'None found'}</p>
                                <h6>Harmonic Progression:</h6>
                                <ul>
                                    ${analysis.harmonicProgression.map(value => 
                                        `<li>${value.toFixed(2)}°</li>`
                                    ).join('')}
                                </ul>
                            `;
                            
                            // Display cycle details
                            let cycleHtml = `
                                <h6>Cycle Analysis:</h6>
                                <ul>
                                    ${Object.entries(analysis.cyclePeriods).map(([key, value]) =>
                                        `<li><strong>${key}:</strong> ${value.toFixed(2)}</li>`
                                    ).join('')}
                                </ul>
                            `;
                            
                            $('#patternDetails').html(patternHtml);
                            $('#cycleDetails').html(cycleHtml);
                            
                            // Update pattern chart
                            updatePatternChart(analysis);
                            
                            $('#patternResults').show();
                        } else {
                            alert('Error: ' + response.error);
                        }
                    },
                    error: function() {
                        alert('Error occurred while analyzing pattern');
                    },
                    complete: function() {
                        $('.loading').hide();
                    }
                });
            });

            // Future Predictions
            $('#predictionForm').on('submit', function(e) {
                e.preventDefault();
                const baseDate = $('#baseDate').val();
                const months = $('#months').val();
                
                $('.loading').show();
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/gann/predict',
                    method: 'POST',
                    data: {
                        baseDate: baseDate,
                        months: months
                    },
                    success: function(response) {
                        if (response.success) {
                            // Display predictions
                            let predictionsHtml = `
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Date</th>
                                                <th>Significance</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            ${response.predictions.map(date => `
                                                <tr>
                                                    <td>${new Date(date).toLocaleDateString()}</td>
                                                    <td>Significant turning point</td>
                                                </tr>
                                            `).join('')}
                                        </tbody>
                                    </table>
                                </div>
                            `;
                            
                            $('#predictions').html(predictionsHtml);
                            
                            // Update prediction chart
                            updatePredictionChart(response.predictions);
                            
                            $('#predictionResults').show();
                        } else {
                            alert('Error: ' + response.error);
                        }
                    },
                    error: function() {
                        alert('Error occurred while generating predictions');
                    },
                    complete: function() {
                        $('.loading').hide();
                    }
                });
            });

            // Chart update functions
            function updateGannWheel(calculation) {
                const wheel = $('#gannWheel');
                wheel.empty();
                
                // Add markers for cardinal points
                const cardinalPoints = calculation.cardinalCrossValues;
                Object.entries(cardinalPoints).forEach(([point, angle]) => {
                    const radians = (angle - 90) * (Math.PI / 180);
                    const radius = 180; // Wheel radius - marker radius
                    const x = 200 + radius * Math.cos(radians);
                    const y = 200 + radius * Math.sin(radians);
                    
                    wheel.append(`
                        <div class="wheel-marker" style="left: ${x}px; top: ${y}px;"
                             title="${point}: ${angle.toFixed(2)}°"></div>
                    `);
                });
            }

            function updateHarmonicChart(calculation) {
                const ctx = document.getElementById('harmonicChart').getContext('2d');
                new Chart(ctx, {
                    type: 'radar',
                    data: {
                        labels: ['0°', '45°', '90°', '135°', '180°', '225°', '270°', '315°'],
                        datasets: [{
                            label: 'Harmonic Values',
                            data: [
                                calculation.harmonicValue,
                                calculation.harmonicValue + 45,
                                calculation.harmonicValue + 90,
                                calculation.harmonicValue + 135,
                                calculation.harmonicValue + 180,
                                calculation.harmonicValue + 225,
                                calculation.harmonicValue + 270,
                                calculation.harmonicValue + 315
                            ].map(v => v % 360),
                            fill: true,
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgb(54, 162, 235)',
                            pointBackgroundColor: 'rgb(54, 162, 235)',
                            pointBorderColor: '#fff',
                            pointHoverBackgroundColor: '#fff',
                            pointHoverBorderColor: 'rgb(54, 162, 235)'
                        }]
                    },
                    options: {
                        scales: {
                            r: {
                                angleLines: {
                                    display: true
                                },
                                suggestedMin: 0,
                                suggestedMax: 360
                            }
                        }
                    }
                });
            }

            function updateProjectionChart(projection) {
                const ctx = document.getElementById('projectionChart').getContext('2d');
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: projection.reversalPoints.map((_, i) => `Point ${i + 1}`),
                        datasets: [{
                            label: 'Reversal Points',
                            data: projection.reversalPoints,
                            fill: false,
                            borderColor: 'rgb(75, 192, 192)',
                            tension: 0.1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false
                    }
                });
            }

            function updatePatternChart(analysis) {
                const ctx = document.getElementById('patternChart').getContext('2d');
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: analysis.harmonicProgression.map((_, i) => `Date ${i + 1}`),
                        datasets: [{
                            label: 'Harmonic Progression',
                            data: analysis.harmonicProgression,
                            fill: false,
                            borderColor: 'rgb(153, 102, 255)',
                            tension: 0.1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false
                    }
                });
            }

            function updatePredictionChart(predictions) {
                const ctx = document.getElementById('predictionChart').getContext('2d');
                const dates = predictions.map(d => new Date(d).toLocaleDateString());
                const values = predictions.map((_, i) => i + 1);
                
                new Chart(ctx, {
                    type: 'scatter',
                    data: {
                        labels: dates,
                        datasets: [{
                            label: 'Significant Dates',
                            data: values.map((v, i) => ({
                                x: i,
                                y: v
                            })),
                            backgroundColor: 'rgb(255, 99, 132)'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            x: {
                                type: 'linear',
                                position: 'bottom',
                                title: {
                                    display: true,
                                    text: 'Time'
                                }
                            },
                            y: {
                                title: {
                                    display: true,
                                    text: 'Significance'
                                }
                            }
                        }
                    }
                });
            }
        });
    </script>
</body>
</html>
