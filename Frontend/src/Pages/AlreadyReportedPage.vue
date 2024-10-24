<template>
  <div :class="['reported-bugs-container', { 'dark-mode': isDarkMode }, 'container', 'mt-5']">
    <div :class="['card', 'shadow-sm', { 'dark-mode': isDarkMode }]">
      <div
        :class="['card-header', { 'dark-mode': isDarkMode }, 'd-flex', 'justify-content-between', 'align-items-center']">
        <h2 class="mb-0 h2">BEJELENTETT HIBÁK</h2>
        <div class="user-actions d-flex">
          <input type="text" class="form-control search-input me-3" placeholder="Keresés..." v-model="searchTerm" /> 
        </div>
      </div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table :class="['table', { 'dark-mode': isDarkMode }, 'table-hover', 'p-4']">
            <thead>
              <tr>
                <th @click="sortBy('name')" style="cursor: pointer;">
                  Hiba neve
                  <i v-if="sortKey === 'name'" :class="['ms-2', sortOrder === 'asc' ? 'bi bi-arrow-up' : 'bi bi-arrow-down']"></i>
                </th>
                <th @click="sortBy('priority')" style="cursor: pointer;">
                  Prioritás
                  <i v-if="sortKey === 'priority'" :class="['ms-2', sortOrder === 'asc' ? 'bi bi-arrow-up' : 'bi bi-arrow-down']"></i>
                </th>
                <th>Címke</th>
                <th>Státusz</th>
                <th @click="sortBy('room')" style="cursor: pointer;">
                  Terem
                  <i v-if="sortKey === 'room'" :class="['ms-2', sortOrder === 'asc' ? 'bi bi-arrow-up' : 'bi bi-arrow-down']"></i>
                </th>
                <th @click="sortBy('reportedBy')" style="cursor: pointer;">
                  Bejelentette
                  <i v-if="sortKey === 'reportedBy'" :class="['ms-2', sortOrder === 'asc' ? 'bi bi-arrow-up' : 'bi bi-arrow-down']"></i>
                </th>
                <th @click="sortBy('reportedAt')" style="cursor: pointer;">
                  Bejelentés ideje
                  <i v-if="sortKey === 'reportedAt'" :class="['ms-2', sortOrder === 'asc' ? 'bi bi-arrow-up' : 'bi bi-arrow-down']"></i>
                </th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(bug, index) in filteredBugs" :key="index" @click="openModal(bug)" style="cursor: pointer">
                <td>{{ bug.name }}</td>
                <td>
                  <div v-if="bug.priority === 0">Nincs prioritás</div>
                  <div v-else class="priority-container">
                    <span :class="['priority-bar', bug.priorityColor]"></span>
                    <span>{{ bug.priority }}</span>
                  </div>
                </td>
                <td>{{ bug.label }}</td>
                <td class="status-column">
                  <span :class="['badge', bug.badgeClass, { 'dark-mode': isDarkMode }]">{{ bug.status }}</span>
                </td>
                <td>{{ bug.room }}</td>
                <td>{{ bug.reportedBy }}</td>
                <td>{{ bug.reportedAt }}</td>
              </tr>
              <tr v-if="filteredBugs.length === 0">
                <td colspan="7" class="text-center">Nincs találat</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Modal -->
    <div v-if="showModal" class="modal-overlay" @click="closeModal">
      <div class="bg" @click.stop>
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title">{{ selectedBug.name }}</h3>
          </div>
          <div class="modal-body">
  <div class="row">
    <div class="col-md-4">
      <div class="d-flex align-items-center mb-2">
        <strong>Prioritás: </strong>
        <div v-if="selectedBug.priority === 0" class="ms-2">Nincs prioritás</div>
        <div v-else class="priority-container ms-2 my-1">
          <span :class="['priority-bar', selectedBug.priorityColor]"></span>
          <span>{{ selectedBug.priority }}</span>
        </div>
      </div>
      <p><strong>Címke:</strong> {{ selectedBug.label }}</p>
      <div class="d-flex align-items-center mb-2 my-1">
        <strong>Státusz: </strong>
        <span :class="['badge', selectedBug.badgeClass, 'ms-2', { 'dark-mode': isDarkMode }]">{{ selectedBug.status }}</span>
      </div>
      <p class="my-3"><strong>Terem:</strong> {{ selectedBug.room }}</p>
      <p class="my-3"><strong>Bejelentette:</strong> {{ selectedBug.reportedBy }}</p>
      <p class="my-3"><strong>Bejelentés ideje:</strong> {{ selectedBug.reportedAt }}</p>
      <p class="my-3" v-if="selectedBug.assignedTo"><strong>Feladatot elvállalta:</strong> {{ selectedBug.assignedTo }}</p>
    </div>
    <div class="col-md-4 description">
      <p><strong>Hiba leírása:</strong></p>
      <div class="description-content">{{ selectedBug.description }}</div>
    </div>
    <div class="col-md-4 photo_box">
      <div class="photo-grid">
        <div v-for="(photo, index) in selectedBug.photos" :key="index" class="photo-item">
          <img :src="photo" class="image-thumbnail" :alt="'Bug photo ' + index" @click="openPhoto(photo)" />
        </div>
      </div>
    </div>
  </div>
</div>



          <div class="modal-footer">
            <button type="button" class="btn btn-primary mx-1" v-if="selectedBug.assignedTo == null" @click="takeTask">Elvállalom</button>
            <button type="button" class="btn btn-secondary mx-1" @click="closeModal">Bezárás</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      bugs: [],
      selectedBug: {},
      showModal: false,
      isDarkMode: false,
      searchTerm: '',
      sortKey: '',
      sortOrder: 'asc',
      showTooltip: false
    };
  },
  computed: {
    filteredBugs() {
      let filtered = this.bugs.filter(bug => {
        const searchTermLower = this.searchTerm.toLowerCase();
        return (
          bug.name.toLowerCase().includes(searchTermLower)
        );
      });

      // Sorting logic based on sortKey and sortOrder
      return filtered.sort((a, b) => {
        let compareA, compareB;

        switch (this.sortKey) {
          case 'name':
          case 'room':
          case 'reportedBy':
            compareA = a[this.sortKey].toLowerCase();
            compareB = b[this.sortKey].toLowerCase();
            if (compareA < compareB) return this.sortOrder === 'asc' ? -1 : 1;
            if (compareA > compareB) return this.sortOrder === 'asc' ? 1 : -1;
            return 0;

          case 'priority':
            compareA = a.priority;
            compareB = b.priority;
            return this.sortOrder === 'asc' ? compareA - compareB : compareB - compareA;

          case 'reportedAt':
            compareA = new Date(a.reportedAt);
            compareB = new Date(b.reportedAt);
            return this.sortOrder === 'asc' ? compareA - compareB : compareB - compareA;

          default:
            return 0; // Default sorting if no key is selected
        }
      });
    }
  },
  mounted() {
    this.fetchBugs();
    this.isDarkMode = localStorage.getItem('theme') === 'dark';
    window.addEventListener('theme-changed', this.updateTheme);
  },
  beforeDestroy() {
    window.removeEventListener('theme-changed', this.updateTheme);
  },
  methods: {
    async fetchBugs() {
  try {
    const response = await fetch('http://localhost:4500/api/hibakKiir');
    if (!response.ok) throw new Error('Network response was not ok');

    const data = await response.json();

    this.bugs = data.map(bug => ({
      id: bug.ID,
      name: bug['Hiba neve'],
      priority: bug['Prioritás'],
      priorityColor: this.getPriorityColor(bug['Prioritás']),
      label: bug['Címke'],
      status: bug['Státusz'],
      badgeClass: bug['Státusz'] === 'Bejelentve' ? 'badge-reported' :
        bug['Státusz'] === 'Kész' ? 'badge-done' :
        bug['Státusz'] === 'Folyamatban' ? 'badge-progress' : '',
      room: bug['Terem'],
      reportedBy: bug['Bejelentette'],
      reportedAt: new Date(bug['Bejelentés ideje']).toLocaleString('hu-HU'),
      assignedTo: bug['assignedTo'],
      description: bug['Hiba leírása'],
      photos: bug.photos ? bug.photos.split(',').map(photo => `http://localhost:4500/uploads/${photo.trim()}`) : [] // Ensure the correct URL format
    }));
  } catch (error) {
    console.error('Error fetching bug data:', error);
  }
},

openPhoto(photo) {
    // Logic to open a larger view of the image
    const imgWindow = window.open(photo, '_blank');
    imgWindow.focus(); // Focus on the new window
  },
    sortBy(key) {
      if (this.sortKey === key) {
        // If the same column is clicked, toggle the sort order
        this.sortOrder = this.sortOrder === 'asc' ? 'desc' : 'asc';
      } else {
        // If a new column is clicked, set it as the sorting key and default to ascending
        this.sortKey = key;
        this.sortOrder = 'asc';
      }
    },
    getPriorityColor(priority) {
      switch (priority) {
        case 1: return 'darkgreen';
        case 2: return 'lightgreen';
        case 3: return 'yellow';
        case 4: return 'orange';
        case 5: return 'red';
        default: return '';
      }
    },
    updateTheme() {
      this.isDarkMode = localStorage.getItem('theme') === 'dark';
    },
    openModal(bug) {
      this.selectedBug = bug;
      this.showModal = true;
    },
    closeModal() {
      this.showModal = false;
    },
    async takeTask() {
  const username = sessionStorage.getItem('username'); // Get logged-in user's username

  if (!username) {
    alert('No user logged in'); // Error handling if username is not available
    return;
  }

  // Update the selected bug with the assigned user
  try {
    const response = await fetch(`http://localhost:4500/api/updateAssignedTo/${this.selectedBug.id}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ assignedTo: username }), // Send the assigned user to backend
    });

    if (!response.ok) {
      throw new Error('Failed to assign the task');
    }

    // Update the frontend after successful response
    this.selectedBug.assignedTo = username;
    alert('Task successfully assigned to you.');
    this.fetchBugs();
  } catch (error) {
    console.error('Error assigning task:', error);
    alert('Failed to assign the task.');
  }
}

  }
};
</script>


<style>

.reported-bugs-container {
  max-width: 900px;
  margin: 0 auto;
}

.search-input {
  width: 200px;
  border: solid 2px #4285f4;
}

.filter-icon {
  font-size: 1.5rem;
  color: #4285f4;
}

.table thead th {
  background-color: #f8f9fa;
  font-weight: bold;
  padding-left: 2em;
  text-align: left;
}

.table tbody td {
  padding-left: 2em;
  text-align: left;
}

.priority-container {
  display: flex;
  align-items: center;
}

.priority-bar {
  display: inline-block;
  width: 50px;
  height: 4px;
  margin-right: 5px;
}

.priority-bar.darkgreen {
  background-color: darkgreen;
}

.priority-bar.lightgreen {
  background-color: lightgreen;
}

.priority-bar.yellow {
  background-color: yellow;
}

.priority-bar.orange {
  background-color: #ff8c00;
}

.priority-bar.red {
  background-color: red;
}

.badge {
  display: inline-block;
  width: 120px;
  text-align: center;
  padding: 0.5rem 0.5rem;
  font-size: 0.9rem;
  font-weight: bold;
  border-radius: 0.5rem;
}

.badge-reported {
  background-color: #f7a611;
  color: #ffffff;
}

.badge-done {
  background-color: #35b821;
  color: #ffffff;
}

.badge-progress {
  background-color: #4169E1;
  color: #ffffff;
}

.table tbody td.status-column {
  width: 150px;
  text-align: center;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  max-width: 100%;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background: white !important;
  padding: 2rem;
  border-radius: 2vh !important;
  max-width: 70vw;
  min-width: 80vw;
  width: 100%;
  z-index: 1000;
}

.description {
  max-width: 100%; /* Ensure it takes full width of the column */
  height: auto; /* Let it grow automatically */
  overflow: hidden; /* Prevent overflow */
  word-wrap: break-word; /* Break long words if necessary */
}

.description-content {
  padding: 0.5rem; /* Add some padding for aesthetics */
  white-space: normal; /* Allow text to wrap onto new lines */
}


.photo-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr); /* Two columns */
  gap: 10px; /* Space between photos */
 
  margin-bottom: 2rem;
}

.photo-item {
  cursor: pointer; /* Indicate that the item is clickable */
}

.photo-item img {
  width: 120px; /* Make the image take the full width of the item */
  height: 120px; /* Maintain aspect ratio */
  border-radius: 0.5rem; /* Optional: Rounded corners */
}

.image-thumbnail {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border: none !important; /* Remove the border */
  box-shadow: none !important; /* Remove any shadow */
  padding: 0 !important; /* Ensure no padding */
  margin: 0; /* Make sure there is no margin */
  background-color: transparent; /* Remove background color */
}


.photo_box {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
}

.carousel-item {
  max-width: fit-content;
  max-height: fit-content;
  margin: 2%;
  object-fit: contain;
  /* Maintain aspect ratio and contain within the box */
  width: 100%;
  /* Take full width */
  height: 25vh;
  /* Fixed height */
}

.modal-title {
  padding-bottom: 1em;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.modal-footer {
  text-align: right;
}

.tooltip-custom {
  position: absolute;
  background-color: #fcc913; /* Background color for light mode */
  color: #000000; /* Text color for light mode */
  padding: 8px;
  border-radius: 4px;
  top: -3.5rem; /* Adjust according to your layout */
  left: 50%; /* Center the tooltip */
  transform: translateX(-50%); /* Ensure centering */
  z-index: 1000;
  white-space: nowrap;
  font-size: 14px;
  text-align: center; /* Center the text */
}


/* DARK MODE */


.dark-mode .table {
  background-color: #222;
  /* Set table background to dark gray */
  color: white;
  /* Default text color for the table */
}

.dark-mode .table thead th {
  background-color: #444;
  /* Table header background for dark mode */
  color: white;
  /* Text color for table header */
}

.dark-mode .table tbody {
  background-color: #222 ;
  /* Set tbody background color for dark mode */
}

.dark-mode .table tbody td {
  background-color: #222;
  /* Set table cell background color for dark mode */
  color: white;
  /* Text color for table cells */
}

.dark-mode .badge {
  background-color: #555;
  /* Badge background color for dark mode */
  color: white;
  /* Badge text color for dark mode */
}

.dark-mode .badge-reported {
  background-color: #f7a611;
  color: #ffffff;
}

.dark-mode .badge-done {
  background-color: #35b821;
  color: #ffffff;
}

.dark-mode .badge-progress {
  background-color: #4169E1;
  color: #ffffff;
}

/* Adjust hover effect for table rows in dark mode */
.dark-mode .table tbody tr:hover {
  background-color: #444;
  /* Change hover background color for dark mode */
}

/* Adjust hover effect for table rows in dark mode */
.dark-mode .table tbody tr {
  border-bottom: 1px solid grey;
  /* Set row borders to grey in dark mode */
}

/* Ensure that the table rows have a grey border in dark mode */
.dark-mode .table tbody tr {
  border-color: grey;
  /* Change the color of the border between rows */
}

/* Modal styles for dark mode */
.dark-mode .modal-content {
  background-color: #444 !important;
  /* Dark background for modal */
  color: white;
  /* Text color for modal */
  border-radius: 2vh;
}

.dark-mode .modal-header {
  background-color: #444;
  /* Header background for modal */
  color: white;
  /* Text color for modal header */
}

.dark-mode .modal-footer {
  background-color: #444;
  /* Footer background for modal */
  color: white;
  /* Text color for modal footer */
}


/* Change the line between the data and the headers to grey in dark mode */
.dark-mode .table thead th {
  border-bottom: 1px solid grey;
  /* Grey border for the header */
}

/* Change the border color of the table rows in dark mode */
.dark-mode .table tbody tr {
  border-color: grey;
  /* Change the color of the border between rows */
}

/* Ensure that the table rows have a grey border in dark mode */
.dark-mode .table tbody tr {
  border-color: grey;
  /* Change the color of the border between rows */
}


/* Change the line between the data and the headers to grey in dark mode */
.dark-mode .table thead th {
  border-bottom: 1px solid grey;
  /* Grey border for the header */
}

.dark-mode .search-input {
  background-color: #A9A9A9;
  /* Light gray background */
  color: white;
  /* White text */
  border-color: black;
  /* Keep the same blue border */
}

.dark-mode .search-input::placeholder {
  color: white;
  /* Make placeholder text white as well */
}

</style>
