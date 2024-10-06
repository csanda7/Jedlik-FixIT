<template>
  <div class="container mt-5">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card shadow-sm border-0 rounded">
          <div class="card-body p-4">
            <h3 class=" m-3">Profilom</h3>
            <form>

              <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" v-model="profile.email" readonly />
              </div>
              <div class="mb-3">
                <label for="firstName" class="form-label">Keresztnév</label>
                <input type="text" class="form-control" id="firstName" v-model="profile.firstName" readonly/>
              </div>
              <div class="mb-3">
                <label for="lastName" class="form-label">Vezetéknév</label>
                <input type="text" class="form-control" id="lastName" v-model="profile.lastName" readonly />
              </div>
              <div class="mb-4">
                <h5>Bejelentett hibák</h5>
                <table class="table table-bordered table-hover">
                  <thead class="table-light">
                    <tr>
                      <th scope="col">ID</th>
                      <th scope="col">Hiba neve</th>
                      <th scope="col">Státusz</th>
                      <th scope="col">Bejelentés ideje</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(bug, index) in bugReports" :key="index">
                      <td>{{ bug.id }}</td>
                      <td>{{ bug.title }}</td>
                      <td>{{ bug.status }}</td>
                      <td>{{ bug.date }}</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="d-flex justify-content-end">
                <button type="submit" class="btn btn-primary" @click="goBack">Vissza</button>
              </div>
            </form>
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
      profile: {
        email: "kovacs.bela@jedlik.eu",
        firstName: "Béla",
        lastName: "Kovács",
      },
      // Mock bug report data
      bugReports: [
        { id: 101, title: "Login button not responsive", status: "Folyamatban", date: "2024-09-15" },
        { id: 104, title: "Profile page crashes", status: "Befejezett", date: "2024-09-20" },
        { id: 107, title: "404 error on settings page", status: "Elvégzésre vár", date: "2024-09-25" },
      ],
    };
  },
  methods: {
    goBack() {
        console.log("Going back...");
      }
  }
};

</script>

<style scoped>
  .card {
    background-color: #f9f9f9;
  }

  .btn-primary {
    background-color: #007bff;
    border-color: #007bff;
  }

  .form-label {
    font-weight: 500;
  }

  input[readonly] {
    background-color: #e9ecef;
    cursor: not-allowed;
  }

  .table-hover tbody tr:hover {
    background-color: #f1f1f1;
  }
</style>