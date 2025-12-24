// Filter System Variables
        let activeFilters = new Set();
        let isDropdownOpen = false;
        let isAppliedFiltersVisible = false;

        // Global Functions
        function toggleFilterDropdown() {
            const dropdown = document.getElementById('filterDropdown');
            const chevron = document.getElementById('filterChevron');
            
            if (isDropdownOpen) {
                dropdown.classList.add('hidden');
                chevron.style.transform = 'rotate(0deg)';
                isDropdownOpen = false;
                isAppliedFiltersVisible = false;
            } else {
                dropdown.classList.remove('hidden');
                chevron.style.transform = 'rotate(180deg)';
                isDropdownOpen = true;
            }
        }

        function toggleAppliedFilters() {
            const appliedSection = document.getElementById('appliedFiltersSection');
            
            if (isAppliedFiltersVisible) {
                appliedSection.classList.add('translate-x-full');
                appliedSection.classList.remove('translate-x-0');
                isAppliedFiltersVisible = false;
            } else {
                appliedSection.classList.remove('translate-x-full');
                appliedSection.classList.add('translate-x-0');
                isAppliedFiltersVisible = true;
            }
        }

        function clearAllFilters() {
            activeFilters.clear();
            document.querySelectorAll('.filter-checkbox').forEach(checkbox => {
                checkbox.checked = false;
            });
            updateAppliedFilters();
            updateFilterBadge();
            applyFilters();
        }

        function removeFilter(filterKey) {
            activeFilters.delete(filterKey);
            const [type, value] = filterKey.split(':');
            const checkbox = document.querySelector(`input[data-type="${type}"][data-value="${value}"]`);
            if (checkbox) checkbox.checked = false;
            updateAppliedFilters();
            updateFilterBadge();
            applyFilters();
        }

        function updateAppliedFilters() {
            const appliedSection = document.getElementById('appliedFiltersSection');
            const appliedCount = document.getElementById('appliedCount');
            const appliedFiltersCount = document.getElementById('appliedFiltersCount');
            const appliedToggle = document.getElementById('appliedFiltersToggle');
            const container = document.getElementById('appliedFiltersContainer');
            
            if (activeFilters.size > 0) {
                // Update counts
                appliedCount.textContent = `${activeFilters.size} active`;
                appliedFiltersCount.textContent = activeFilters.size;
                
                // Show the toggle button in header
                appliedToggle.classList.remove('hidden');
                
                // Clear and rebuild applied filters
                container.innerHTML = '';
                activeFilters.forEach(filterKey => {
                    const [type, value] = filterKey.split(':');
                    const badge = createFilterBadge(type, value, filterKey);
                    container.appendChild(badge);
                });
            } else {
                // Hide the toggle button
                appliedToggle.classList.add('hidden');
                
                // Hide applied filters panel if visible
                if (isAppliedFiltersVisible) {
                    toggleAppliedFilters();
                }
            }
        }

        function createFilterBadge(type, value, filterKey) {
            const badge = document.createElement('span');
            badge.className = 'inline-flex items-center gap-1 px-2 py-1 bg-blue-100 text-blue-800 text-xs font-medium rounded-full hover:bg-blue-200 transition-colors';
            badge.innerHTML = `
                <span class="capitalize">${type}: ${value}</span>
                <button onclick="removeFilter('${filterKey}')" class="ml-1 hover:bg-blue-300 rounded-full p-0.5 transition-colors">
                    <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
            `;
            return badge;
        }

        function updateFilterBadge() {
            const filterCount = document.getElementById('filterCount');
            const filterCount2 = document.getElementById('filterCount2');
            const filterButton = document.getElementById('filterButton');
            
            if (activeFilters.size > 0) {
                filterCount.textContent = activeFilters.size;
                filterCount.classList.remove('hidden');
                filterCount2.textContent = `${activeFilters.size} filter${activeFilters.size !== 1 ? 's' : ''} selected`;
                filterButton.classList.add('border-blue-300', 'bg-blue-50');
                filterButton.classList.remove('border-gray-300');
            } else {
                filterCount.classList.add('hidden');
                filterCount2.textContent = '0 filters selected';
                filterButton.classList.remove('border-blue-300', 'bg-blue-50');
                filterButton.classList.add('border-gray-300');
            }
        }

        function applyFilters() {
            const rows = document.querySelectorAll('tbody tr');
            
            if (activeFilters.size === 0) {
                rows.forEach(row => row.style.display = '');
                return;
            }
            
            rows.forEach(row => {
                let shouldShow = true;
                
                for (const filterKey of activeFilters) {
                    const [type, value] = filterKey.split(':');
                    if (!checkRowMatchesFilter(row, type, value)) {
                        shouldShow = false;
                        break;
                    }
                }
                
                row.style.display = shouldShow ? '' : 'none';
            });
        }

        function checkRowMatchesFilter(row, filterType, value) {
            const cells = row.querySelectorAll('td');
            
            switch(filterType) {
                case 'category':
                    const categorySpan = cells[3]?.querySelector('span');
                    return categorySpan && categorySpan.textContent.toLowerCase().includes(value.toLowerCase());
                    
                case 'status':
                    const statusSpan = cells[4]?.querySelector('span');
                    return statusSpan && statusSpan.textContent.toLowerCase().includes(value.toLowerCase());
                    
                case 'availability':
                    const availabilitySpan = cells[5]?.querySelector('span');
                    return availabilitySpan && availabilitySpan.textContent.toLowerCase().includes(value.toLowerCase());
                    
                case 'tags':
                    const tagSpans = cells[6]?.querySelectorAll('span');
                    if (tagSpans) {
                        return Array.from(tagSpans).some(span => 
                            span.textContent.toLowerCase().includes(value.toLowerCase())
                        );
                    }
                    return false;
                    
                default:
                    return false;
            }
        }

        document.addEventListener('DOMContentLoaded', function () {


            // Select all checkbox functionality
            const selectAllCheckbox = document.querySelector('thead input[type="checkbox"]');
            const rowCheckboxes = document.querySelectorAll('tbody input[type="checkbox"]');

            if (selectAllCheckbox) {
                selectAllCheckbox.addEventListener('change', function() {
                    rowCheckboxes.forEach(checkbox => {
                        checkbox.checked = this.checked;
                    });
                });
            }

            // Filter checkbox functionality
            document.querySelectorAll('.filter-checkbox').forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    const filterType = this.getAttribute('data-type');
                    const filterValue = this.getAttribute('data-value');
                    const filterKey = `${filterType}:${filterValue}`;
                    
                    if (this.checked) {
                        activeFilters.add(filterKey);
                    } else {
                        activeFilters.delete(filterKey);
                    }
                    
                    updateAppliedFilters();
                    updateFilterBadge();
                });
            });

            // Close dropdown when clicking outside
            document.addEventListener('click', function(event) {
                if (!event.target.closest('#filterButton') && !event.target.closest('#filterDropdown')) {
                    if (isDropdownOpen) {
                        toggleFilterDropdown();
                    }
                }
            });

            // Prevent dropdown from closing when clicking inside
            document.getElementById('filterDropdown').addEventListener('click', function(e) {
                e.stopPropagation();
            });
        });