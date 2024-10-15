<template>
  <div class="reported-bugs-container container mt-5">
    <div class="card shadow-sm">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h2 class="mb-0 h2">BEJELENTETT HIBÁK</h2>
        <div class="user-actions d-flex">
          <input type="text" class="form-control search-input me-3" placeholder="Keresés..." />
          <i class="fas fa-filter filter-icon"></i>
        </div>
      </div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-hover p-4">
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
                  <div class="priority-container">
                    <span :class="['priority-bar', bug.priorityColor]"></span>
                    <span>{{ bug.priority }}</span>
                  </div>
                </td>
                <td>
                  <span :class="['badge', bug.badgeClass]">{{ bug.label }}</span>
                </td>
                <td>{{ bug.status }}</td>
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
                <p><strong>Prioritás:</strong> {{ selectedBug.priority }}</p>
                <p><strong>Címke:</strong> {{ selectedBug.label }}</p>
                <p><strong>Státusz:</strong> {{ selectedBug.status }}</p>
                <p><strong>Terem:</strong> {{ selectedBug.room }}</p>
                <p><strong>Bejelentette:</strong> {{ selectedBug.reportedBy }}</p>
                <p><strong>Bejelentés ideje:</strong> {{ selectedBug.reportedAt }}</p>
                <p v-if="selectedBug.assignedTo"><strong>Feladatot elvállalta:</strong> {{ selectedBug.assignedTo }}</p> <!-- New row for assigned user -->
              </div>
              <div class="col-md-4 description">
                <p><strong>Hiba leírása:</strong> {{ selectedBug.description }}</p>
              </div>
              <div class="col-md-4 photo_box">
                <div id="bugCarousel" class="carousel slide" data-bs-ride="carousel">
                  
                  <button class="carousel-control-prev" type="button" data-bs-target="#bugCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                  </button>
                  <button class="carousel-control-next" type="button" data-bs-target="#bugCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                  </button>
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
      bugs: [], // Initially empty array
      selectedBug: {},
      showModal: false,
    };
  },
  mounted() {
    // Fetch bugs from backend when the component is mounted
    this.fetchBugs();
  },
  methods: {
    async fetchBugs() {
  try {
    const response = await fetch('http://localhost:4500/api/hibakKiir');
    const data = await response.json();
    
    this.bugs = data.map(bug => ({
      name: bug['Hiba neve'],
      priority: bug['Prioritás'],
      priorityColor: bug['Prioritás'] >= 5 ? 'red' : 'yellow',
      label: bug['Címke'],
      badgeClass: bug['Címke'] === 'Hardver' ? 'badge-hardware' : 'badge-software',
      status: bug['Státusz'],
      room: bug['Terem'],
      reportedBy: bug['Bejelentette'],
      reportedAt: new Date(bug['Bejelntés ideje']).toLocaleString('hu-HU'), // Format date
      assignedTo: null,
      description: bug['Hiba leírása']
    }));

  } catch (error) {
    console.error('Error fetching bug data:', error);
  }
},

    openModal(bug) {
      this.selectedBug = bug;
      this.showModal = true; // Show the modal
    },
    closeModal() {
      this.showModal = false; // Hide the modal
    },
    takeTask() {
      const username = sessionStorage.getItem('username'); // Get logged-in user's username

      if (!username) {
        alert('No user logged in'); // Error handling if username is not available
        return;
      }

      this.selectedBug.assignedTo = username;
    }
  },
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

.priority-bar.yellow {
  background-color: #ffc107;
}

.priority-bar.red {
  background-color: #dc3545;
}

.badge {
  padding: 0.5rem 1rem;
  font-size: 0.8rem;
  font-weight: bold;
  border-radius: 0.5rem;
}

.badge-hardware {
  background-color: #9757f8;
  color: #ffffff;
}

.badge-software {
  background-color: #ffa73e;
  color: #ffffff;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  max-width: 100%;
  background: rgba(0, 0, 0, 0.6);
  /* Dark background overlay */
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  padding: 2rem;
  border-radius: 5vh;
  max-width: 70vw;
  min-width: 80vw;
  width: 100%;

  z-index: 1000;
}
.modal_photo{
  max-width: fit-content;
  max-height: fit-content;
  width: 80%;
  height: 80%;
  
}
.photo_box{
  display: flex;
  justify-content: center; 
  align-items: center; 
  height: 100%; 
}

.carousel-item{
  max-width: fit-content;
  max-height: fit-content;
  margin: 2%;
  object-fit: contain;  /* Maintain aspect ratio and contain within the box */
  width: 100%;  /* Take full width */
  height: 25vh /* Fixed height */
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
</style>