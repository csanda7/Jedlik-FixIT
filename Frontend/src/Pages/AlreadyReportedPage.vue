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
                <p><strong>Hiba leírása:</strong> {{ selectedBug.bugDescription }}</p>
              </div>
              <div class="col-md-4 photo_box">
                <div id="bugCarousel" class="carousel slide" data-bs-ride="carousel">
                  <div class="carousel-inner">
                    <div class="carousel-item active">
                      <img src="../assets/Jedlik_logo_2020_200_3c5beeccf8.png" class="d-block w-100" alt="First slide">
                    </div>
                    <div class="carousel-item">
                      <img src="D:\Programs\Jedlik-FixIT\Frontend\src\assets\3101886743_5d9c49b9a5_b.jpg" class="d-block w-100" alt="Second slide">
                    </div>
                    <div class="carousel-item">
                      <img src="D:\Programs\Jedlik-FixIT\Frontend\src\assets\BSOD_Windows_8-1080x660.png" class="d-block w-100" alt="Third slide">
                    </div>
                  </div>
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
      bugs: [
        {
          name: 'Törött billentyűzet',
          priority: 3,
          priorityColor: 'yellow',
          label: 'HARDVER',
          badgeClass: 'badge-hardware',
          status: 'Folyamatban',
          room: '116',
          reportedBy: 'Nagy Gergő',
          reportedAt: '2024-09-26 16:12',
          bugDescription : 'Aliquam pharetra id eros quis fermentum. Ut varius, sem viverra malesuada feugiat, enim nisi laoreet urna, ut sollicitudin sapien libero ut dui. Etiam vel nibh tortor. Fusce elit sem, vulputate id semper ac, efficitur quis justo. Interdum et malesuada fames.',
          assignedTo: null
        },
        {
          name: 'Windows kékhalál',
          priority: 5,
          priorityColor: 'red',
          label: 'SZOFTVER',
          badgeClass: 'badge-software',
          status: 'Folyamatban',
          room: '203',
          reportedBy: 'Csó Ronáldó',
          reportedAt: '2024-09-27 10:25',
          bugDescription : 'Aliquam pharetra id eros quis fermentum. Ut varius, sem viverra malesuada feugiat, enim nisi laoreet urna, ut sollicitudin sapien libero ut dui. Etiam vel nibh tortor. Fusce elit sem, vulputate id semper ac, efficitur quis justo. Interdum et malesuada fames.',
          assignedTo: null
        },
      ],
      selectedBug: {},
      showModal: false,
    };
  },
  methods: {
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

      // Assign the task to the logged-in user
      this.selectedBug.assignedTo = username;

      // Optionally, you can update the task in your bugs array if needed
      const index = this.bugs.findIndex(bug => bug.name === this.selectedBug.name);
      if (index !== -1) {
        this.bugs[index].assignedTo = username;
      }

      // Optionally close the modal after assigning
      // this.showModal = false;
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