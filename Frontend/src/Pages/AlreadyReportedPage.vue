<template>
  <div :class="['reported-bugs-container', { 'dark-mode': isDarkMode }, 'container', 'mt-5']">
  <div :class="['card', 'shadow-sm', { 'dark-mode': isDarkMode }]">
    <div :class="['card-header', { 'dark-mode': isDarkMode }, 'd-flex', 'justify-content-between', 'align-items-center']">
      <h2 class="mb-0 h2">BEJELENTETT HIBÁK</h2>
      <div class="user-actions d-flex">
        <input type="text" class="form-control search-input me-3" placeholder="Keresés..." />
        <i class="fas fa-filter filter-icon"></i>
      </div>
    </div>
    <div class="card-body p-0">
      <div class="table-responsive">
        <table :class="['table', { 'dark-mode': isDarkMode }, 'table-hover', 'p-4']">
            <thead>
              <tr>
                <th>Hiba neve</th>
                <th>Prioritás</th>
                <th>Címke</th>
                <th>Státusz</th>
                <th>Terem</th>
                <th>Bejelentette</th>
                <th>Bejelntés ideje</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(bug, index) in bugs" :key="index" @click="openModal(bug)" style="cursor: pointer">
                <td>{{ bug.name }}</td>
                <td>
                  <div v-if="bug.priority === 0">
                    Nincs megadva prioritás
                  </div>
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
        <div class="priority-container ms-2">
          <span :class="['priority-bar', selectedBug.priorityColor]"></span>
          <span>{{ selectedBug.priority }}</span>
        </div>
      </div>
      <p><strong>Címke:</strong> {{ selectedBug.label }}</p>
      <div class="d-flex align-items-center mb-2">
        <strong>Státusz: </strong>
        <span :class="['badge', selectedBug.badgeClass,'ms-2',  { 'dark-mode': isDarkMode }] ">{{ selectedBug.status }}</span>
      </div>
      <p><strong>Terem:</strong> {{ selectedBug.room }}</p>
      <p><strong>Bejelentette:</strong> {{ selectedBug.reportedBy }}</p>
      <p><strong>Bejelentés ideje:</strong> {{ selectedBug.reportedAt }}</p>
      <p v-if="selectedBug.assignedTo"><strong>Feladatot elvállalta:</strong> {{ selectedBug.assignedTo }}</p>
    </div>
    <div class="col-md-4 description">
      <p><strong>Hiba leírása:</strong> {{ selectedBug.description }}</p>
    </div>
    <div class="col-md-4 photo_box">
      <div id="bugCarousel" class="carousel slide" data-bs-ride="carousel">
        <!-- Add carousel items here for photos if applicable -->
      </div>
    </div>
  </div>
</div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary mx-1" v-if="!selectedBug.assignedTo" @click="takeTask">Elvállalom</button>
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
    };
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
        console.log('API Response:', data); // Log the entire response to check if ID is present
        
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
          assignedTo: bug['assignedTo'], // Ensure this is fetched correctly
          description: bug['Hiba leírása']
        }));
      } catch (error) {
        console.error('Error fetching bug data:', error);
      }
    },
    getPriorityColor(priority) {
      switch (priority) {
        case 1: return 'darkgreen';
        case 2: return 'lightgreen';
        case 3: return 'yellow';
        case 4: return 'orange';
        case 5: return 'red';
        default: return ''; // No color for 0 or invalid values
      }
    },
    updateTheme() {
      this.isDarkMode = localStorage.getItem('theme') === 'dark';
    },
    openModal(bug) {
      this.selectedBug = bug;
      this.showModal = true; // Show the modal
    },
    closeModal() {
      this.showModal = false; // Hide the modal
    },
    async takeTask() {
      const username = sessionStorage.getItem('username'); // Get logged-in user's username

      if (!username) {
        alert('No user logged in');
        return;
      }

      // Log selected bug before sending the request
      console.log('Taking task for Bug ID:', this.selectedBug.id);

      if (!this.selectedBug.id) {
        alert('Bug ID is missing');
        return;
      }

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

.h2 {
  color: rgb(59, 59, 59);
  padding: 0.5em;
}

.card-header {
  background-color: #f93943;
  color: white;
  padding: 1.2rem;
  border-bottom: none;
}

.card-header h1 {
  margin-left: -10px;
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

.priority-bar.darkgreen { background-color: darkgreen; }
.priority-bar.lightgreen { background-color: lightgreen; }
.priority-bar.yellow { background-color: yellow; }
.priority-bar.orange { background-color: #ff8c00; }
.priority-bar.red { background-color: red; }

.badge {
  display: inline-block;
  width: 120px;
  text-align: center;
  padding: 0.5rem 0.5rem;
  font-size: 0.9rem;
  font-weight: bold;
  border-radius: 0.5rem;
}

.badge-reported { background-color: #f7a611; color: #ffffff; }
.badge-done { background-color: #35b821; color: #ffffff; }
.badge-progress { background-color: #4169E1; color: #ffffff; }

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
  background: white;
  padding: 2rem;
  border-radius: 2vh;
  max-width: 70vw;
  min-width: 80vw;
  width: 100%;
  z-index: 1000;
}

.modal_photo {
  max-width: fit-content;
  max-height: fit-content;
  width: 80%;
  height: 80%;
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
  object-fit: contain;  /* Maintain aspect ratio and contain within the box */
  width: 100%;  /* Take full width */
  height: 25vh; /* Fixed height */
}

.modal-title {
  padding-bottom: 1em;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.bg {
  background-color: rgb(255, 255, 255);
  z-index: 500;
  border-radius: 5vh;
}

.btn-close {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
}

.modal-footer {
  text-align: right;
}

.btn-secondary {
  background-color: #636363;
  color: white;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.btn-secondary:hover {
  background-color: #4285f4;
  color: white;
}


.dark-mode {
  background-color: black; /* Set background color to black */
  color: white; /* Set default text color to white */
}

.dark-mode .card {
  background-color: #333; /* Card background for dark mode */
  color: white; /* Text color inside card */
}

.dark-mode .table {
  background-color: #222; /* Set table background to dark gray */
  color: white; /* Default text color for the table */
}

.dark-mode .table thead th {
  background-color: #444; /* Table header background for dark mode */
  color: white; /* Text color for table header */
}

.dark-mode .table tbody {
  background-color: #222; /* Set tbody background color for dark mode */
}

.dark-mode .table tbody td {
  background-color: #222; /* Set table cell background color for dark mode */
  color: white; /* Text color for table cells */
}

.dark-mode .badge {
  background-color: #555; /* Badge background color for dark mode */
  color: white; /* Badge text color for dark mode */
}

.dark-mode .badge-reported { background-color: #f7a611; color: #ffffff; }
.dark-mode .badge-done { background-color: #35b821; color: #ffffff; }
.dark-mode .badge-progress { background-color: #4169E1; color: #ffffff; }

/* Adjust hover effect for table rows in dark mode */
.dark-mode .table tbody tr:hover {
  background-color: #444; /* Change hover background color for dark mode */
}

/* Adjust hover effect for table rows in dark mode */
.dark-mode .table tbody tr {
  border-bottom: 1px solid grey; /* Set row borders to grey in dark mode */
}

/* Ensure that the table rows have a grey border in dark mode */
.dark-mode .table tbody tr {
  border-color: grey; /* Change the color of the border between rows */
}

/* Modal styles for dark mode */
.dark-mode .modal-content {
  background-color: #444; /* Dark background for modal */
  color: white; /* Text color for modal */
  border-radius: 2vh;
}

.dark-mode .modal-header {
  background-color: #444; /* Header background for modal */
  color: white; /* Text color for modal header */
}

.dark-mode .modal-footer {
  background-color: #444; /* Footer background for modal */
  color: white; /* Text color for modal footer */
}

/* Dark mode button styles */
.dark-mode .btn-primary {
  background-color: #007bff; /* Keep primary button color */
  border-color: #007bff; /* Border color for primary button */
}

.dark-mode .btn-secondary {
  background-color: #636363; /* Dark mode secondary button color */
  color: white; /* Text color for secondary button */
}

.dark-mode .btn-secondary:hover {
  background-color: #4285f4; /* Change hover color for secondary button */
  color: white; /* Text color on hover */
}


/* Change the line between the data and the headers to grey in dark mode */
.dark-mode .table thead th {
  border-bottom: 1px solid grey; /* Grey border for the header */
}

/* Change the border color of the table rows in dark mode */
.dark-mode .table tbody tr {
  border-color: grey; /* Change the color of the border between rows */
}

/* Ensure that the table rows have a grey border in dark mode */
.dark-mode .table tbody tr {
  border-color: grey; /* Change the color of the border between rows */
}


/* Change the line between the data and the headers to grey in dark mode */
.dark-mode .table thead th {
  border-bottom: 1px solid grey; /* Grey border for the header */
}

.dark-mode .search-input {
  background-color: #A9A9A9; /* Light gray background */
  color: white; /* White text */
  border-color: black; /* Keep the same blue border */
}

.dark-mode .search-input::placeholder {
  color: white; /* Make placeholder text white as well */
}






</style>
