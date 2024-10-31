<template>
  <div :class="['container', 'mt-5', isDarkMode ? 'dark-mode' : 'light-mode']">
    <div class="card p-4 shadow mx-auto" style="max-width: 600px;">
      <h1 class="text-center my-2">HIBA BEJELENTÉSE</h1>

      <!-- Pop-Up Message -->
      <div v-if="showPopup" class="alert alert-danger" role="alert">
        Kérjük, töltse ki az összes kötelező mezőt!
      </div>

      <div v-if="showSuccessPopup" class="alert alert-success" role="alert">
        Hiba sikeresen elküldve!
      </div>

      <div class="my-3">
        <label for="bugName" class="form-label">Hiba megnevezése <span class="text-danger">*</span></label>
        <input 
          type="text" 
          :class="['form-control', isDarkMode ? 'dark-textbox' : '']"
          id="bugName" 
          v-model="bugName" 
          placeholder="Adja meg a hiba nevét röviden" 
          maxlength="30"
          required 
          @input="setCookie('bugName', bugName)">
      </div>

      <div class="mb-3">
        <label for="bugDescription" class="form-label">Hiba leírása <span class="text-danger">*</span></label>
        <textarea 
          :class="['form-control', isDarkMode ? 'dark-textbox' : '']" 
          id="bugDescription" 
          v-model="bugDescription" 
          rows="3" 
          placeholder="Adja meg a hiba leírását" 
          maxlength="300" 
          @input="adjustTextareaHeight($event); setCookie('bugDescription', bugDescription);" 
          required>
        </textarea>
      </div>

      <!-- Dátum és idő mező hozzáadása -->
<div class="my-3">
  <label for="dateTime" class="form-label">Hiba bekövetkezésének ideje</label>
  <input 
  type="datetime-local" 
  :class="['form-control', isDarkMode ? 'dark-textbox' : '']" 
  id="dateTime timestamp" 
  v-model="dateTime" 
  @change="setCookie('dateTime', dateTime)">

</div>

     <div class="row">
  <!-- Left Column: Location, Label, and Priority -->
  <div class="col-md-6">
    <!-- Location Dropdown -->
    <div class="dropdown mb-2">
      <button 
        :class="['btn dropdown-toggle w-100 my-2', isDarkMode ? 'dark-dropdown' : '']" 
        type="button" 
        id="locationDropdown" 
        data-bs-toggle="dropdown" 
        aria-expanded="false">
        {{ location || 'Helyszín' }} <span class="text-danger" v-if="!location">*</span>
      </button>
      <ul class="dropdown-menu w-100" aria-labelledby="locationDropdown">
        <li><a class="dropdown-item text-center" href="#" @click="selectLocation('Első terem')">Első terem</a></li>
        <li><a class="dropdown-item text-center" href="#" @click="selectLocation('Másik terem 2')">Másik terem 2</a></li>
        <li><a class="dropdown-item text-center" href="#" @click="selectLocation('Másik terem 3')">Másik terem 3</a></li>
        <li><a class="dropdown-item text-center" href="#" @click="selectLocation('Egyéb')">Egyéb</a></li>
      </ul>
    </div>
    <div v-if="showOtherLocation" class="my-3 mt-0">
      <input type="text" 
        :class="['form-control border-secondary', isDarkMode ? 'dark-textbox' : '']" 
        id="otherLocation" 
        v-model="otherLocation" 
        placeholder="Adja meg a helyszínt" 
        @input="setCookie('otherLocation', otherLocation)">
    </div>

    <!-- Label Dropdown -->
    <div class="dropdown mb-2">
      <button 
        :class="['btn dropdown-toggle w-100 my-2', isDarkMode ? 'dark-dropdown' : '']" 
        type="button" 
        id="labelDropdown" 
        data-bs-toggle="dropdown" 
        aria-expanded="false">
        {{ label || 'Címkék' }} <span class="text-danger" v-if="!label">*</span>
      </button>
      <ul class="dropdown-menu w-100" aria-labelledby="labelDropdown">
        <li><a class="dropdown-item text-center" href="#" @click="selectlabel('Hardver')">Hardver</a></li>
        <li><a class="dropdown-item text-center" href="#" @click="selectlabel('Szoftver')">Szoftver</a></li>
        <li><a class="dropdown-item text-center" href="#" @click="selectlabel('Egyéb')">Egyéb</a></li>
      </ul>
    </div>

    <!-- Priority Radio Buttons -->
    <div class="mb-2">
      <label for="priority" class="form-label">Prioritás:</label>
      <div class="d-flex flex-row">
        <div class="form-check me-2">
          <input class="form-check-input" type="radio" v-model="priority" id="priority0" value="0" @change="setCookie('priority', priority)" />
          <label class="form-check-label" for="priority0">Nincs</label>
        </div>
        <div class="form-check me-2" v-for="n in 5" :key="n">
          <input class="form-check-input" type="radio" v-model="priority" :id="'priority' + n" :value="n" @change="setCookie('priority', priority)" />
          <label class="form-check-label" :for="'priority' + n">{{ n }}</label>
        </div>
      </div>
    </div>
  </div>

  <!-- Right Column: Picture Upload Button aligned with Location -->
  <div class="col-md-6">
    <!-- Picture Upload Button -->
    <!-- Picture Upload Button -->
<div >
  <label for="photo" class="btn-primary pictureUploadButton w-100 ">Kép feltöltése</label>
  <input 
    type="file" 
    class="form-control" 
    id="photo" 
    @change="onFileChange" 
    accept=".png, .jpg, .jpeg, .heic" 
    multiple 
    style="display: none;"  
  >
</div>
<div class="image-preview-container mt-3">
  <div v-for="(photo, index) in photoPreviews" :key="index" class="image-preview">
    <img :src="photo" class="img-thumbnail" alt="Preview" />
    <button type="button" class="btn btn-danger btn-sm" @click="removePhoto(index)">X</button>
  </div>
</div>
    
  </div>
</div>


      <div class="d-grid gap-2 d-flex justify-content-center my-3">
        <button type="button" class="btn btn-secondary w-100" @click="confirmReset">Adatok törlése</button>
        <button type="submit" class="btn btn-primary w-100" @click="bekuldes">Hiba beküldése</button>
      </div>
    </div>
  </div>
</template>





<script>
import axios from 'axios';
import CryptoJS from 'crypto-js'; // Import the crypto-js library
import moment from 'moment-timezone';

export default {
  data() {
    return {
      bugName: this.getCookie('bugName') || '',
      priority: this.getCookie('priority') || '0',
      bugDescription: this.getCookie('bugDescription') || '',
      photos: [],
      photoPreviews: [],
      location: this.getCookie('location') || '',
      label: this.getCookie('label') || '',
      showOtherLocation: false,
      otherLocation: this.getCookie('otherLocation') || '',
      showPopup: false, // State for the popup message
      showSuccessPopup: false,
      isDarkMode: false,
      dateTime: this.getCookie('dateTime') || '', // Új dátum-idő változó
    };
  },

  mounted() {
    this.isDarkMode = localStorage.getItem('theme') === 'dark';
    window.addEventListener('theme-changed', this.updateTheme);
    // A pillanatnyi idő beállítása a Budapest időzónájának megfelelően
    const now = moment().tz('Europe/Budapest'); // Budapest időzóna
    this.dateTime = now.format('YYYY-MM-DDTHH:mm'); // ISO formátumban, levágva a másodperceket
    window.addEventListener('theme-changed', this.updateTheme);
  },
  beforeDestroy() {
    window.removeEventListener('theme-changed', this.updateTheme);
  },
  methods: {
    setCookie(name, value, days = 7) {
      const d = new Date();
      d.setTime(d.getTime() + (days * 24 * 60 * 60 * 1000));
      const expires = "expires=" + d.toUTCString();
      document.cookie = name + "=" + value + ";" + expires + ";path=/";
    },
    getCookie(name) {
      const nameEQ = name + "=";
      const ca = document.cookie.split(';');
      for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
      }
      return '';
    },


    onFileChange(event) {
    const files = event.target.files;
    if (files.length + this.photos.length > 4) {
      alert('Maximum 4 képet tölthet fel.');
      return;
    }
    
    for (let i = 0; i < files.length; i++) {
      const file = files[i];

      // Hash the filename
      const hashedName = CryptoJS.MD5(file.name).toString(); // Create a hash of the filename

      // Create a new file with the hashed name and the same type
      const newFile = new File([file], hashedName + '.' + file.name.split('.').pop(), {
        type: file.type,
      });
      
      this.photos.push(newFile); // Add the new file to the photos array

      // Create a FileReader to generate preview
      const reader = new FileReader();
      reader.onload = (e) => {
        this.photoPreviews.push(e.target.result);
      };
      reader.readAsDataURL(file); // Read file as data URL to display it as an image
    }
  },

  removePhoto(index) {
    this.photos.splice(index, 1); // Remove photo from the photos array
    this.photoPreviews.splice(index, 1); // Remove the preview as well
  },
    reset() {
      this.bugName = '';
      this.priority = '0';
      this.bugDescription = '';
      this.photos = [];
      this.photoPreviews = [];
      this.location = '';
      this.label = '';
      this.showOtherLocation = false;
      this.otherLocation = '';
      this.dateTime = moment().tz('Europe/Budapest').format('YYYY-MM-DDTHH:mm'); // Frissítve, hogy a jelenlegi időt mutassa;
      this.showPopup = false; // Reset the popup on reset

      // Clear cookies
      this.setCookie('bugName', '');
      this.setCookie('priority', '0');
      this.setCookie('bugDescription', '');
      this.setCookie('location', '');
      this.setCookie('label', '');
      this.setCookie('otherLocation', '');
    },
    updateTheme() {
      this.isDarkMode = localStorage.getItem('theme') === 'dark';
    },
    adjustTextareaHeight(event) {
      const textarea = event.target;
      textarea.style.height = 'auto'; // Reset height to auto to correctly calculate the new height
      textarea.style.height = textarea.scrollHeight + 'px'; // Set height based on scroll height
    },
    selectLocation(selectedLocation) {
      this.location = selectedLocation;
      this.showOtherLocation = selectedLocation === 'Egyéb';
      this.setCookie('location', selectedLocation);
    },
    selectlabel(selectedlabel) {
      this.label = selectedlabel;
      this.setCookie('label', selectedlabel);
    },
    confirmReset() {
      if (confirm("Biztosan törölni szeretnéd az összes adatot?")) {
        this.reset();
      }
    },
    bekuldes() {
  if (!this.bugName || !this.bugDescription || !this.location || !this.label) {
    this.showPopup = true; // Kötelező mezők kitöltése
    setTimeout(() => {
      this.showPopup = false;
    }, 5000); // 5 másodperc eltűnés
    return;
  }

  const username = sessionStorage.getItem('username');
  if (!username) {
    alert('No user logged in');
    return;
  }

  const formData = new FormData();
  formData.append('bugName', this.bugName);
  formData.append('bugDescription', this.bugDescription);
  formData.append('reported_by', username);
  formData.append('location', this.location === 'Egyéb' ? this.otherLocation : this.location);
  formData.append('priority', this.priority);
  formData.append('label', this.label);
  formData.append('hiba_idopont', this.dateTime);
  this.photos.forEach(photo => {
    formData.append('photos', photo);
  });

  axios.post("http://localhost:4500/api/bugReport", formData, {
    headers: { 'Content-Type': 'multipart/form-data' }
  })
  .then((res) => {
    if (res.data.msg === "Validation Failed") {
      // Hibakezelés az űrlap hibáira
      // ...
    } else {
      this.showSuccessPopup = true; // Sikeres beküldés üzenet
      setTimeout(() => {
        this.showSuccessPopup = false;
      }, 5000); // 5 másodperc eltűnés
      this.reset(); // Űrlap törlése
    }
  })
  .catch((error) => {
    console.error('Error submitting bug report:', error);
    alert('Error: Unable to submit bug report.');
  });
}

  }
};


</script>

<style scoped>
.image-preview-container {
  margin-left: 3rem;
  display: flex;
  gap: 5px;
  flex-wrap: wrap;
}

.image-preview {
  position: relative;
  width: 85px; /* Set a smaller fixed width */
  height: 85px; /* Set a smaller fixed height */
}

.img-thumbnail {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border: none !important; /* Remove the border */
  box-shadow: none !important; /* Remove any shadow */
  padding: 0 !important; /* Ensure no padding */
  margin: 0; /* Make sure there is no margin */
  background-color: transparent; /* Remove background color */
}

.btn-danger {
  position: absolute;
  top: 0;
  right: 0;
  padding: 2px 4px;
  font-size: 10px;
}
.pictureUploadButton{
  margin-top: 0.5rem;
  padding: 5px;
  font-size: 1.1rem;
  border-radius: 5px;
  transition: background-color 0.3s ease;
  text-align: center;
  border: px solid black;
  background-color: #4285f4;
  border-color: #4285f4;
  color: white;
}

.alert {
  margin-top: 0 ;
  margin-bottom: 0 ;
  max-height: fit-content;
}

.search-input {
  width: 200px;
  border: solid 2px #4285f4;
}

.filter-icon {
  font-size: 1.5rem;
  color: #4285f4;
}

.dropdown-toggle {
  border: 1px solid black; /* Black border for dropdown button in light mode */
}

.dropdown-menu {
  border: 1px solid black; /* Black border for dropdown menu */
}


/* General dark mode styles */


/* Dark mode dropdown */
.dark-dropdown {
  background-color: #444;
  color: white;
  border: 1px solid #777;
}

.dark-dropdown .dropdown-item:hover {
  background-color: #555;
}
/* Dark mode textbox */
.dark-textbox {
  background-color: #444;
  color: white;
  border: 1px solid #777;
}

.alert-success {
  background-color: #d4edda; /* Zöld háttér */
  color: #155724; /* Zöld szöveg */
  border-color: #c3e6cb;
  margin-top: 0;
  margin-bottom: 0;
  max-height: fit-content;
}

/* Dátummező darkmode */
input[type="datetime-local"].dark-textbox {
  background-color: #444;
  color: #fff;
  border: 1px solid #777;
}


#bugName::placeholder{
  color: rgb(168, 168, 168);
}
#bugDescription::placeholder{
  color: rgb(168, 168, 168);
}
#otherLocation::placeholder{
  color: rgb(168, 168, 168);
}

.dropdown-item {
  width: auto !important;
  min-width: unset !important;
}

</style>
