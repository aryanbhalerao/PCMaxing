import React, { useState, useEffect, useRef } from 'react';
import './App.css';

interface PCComponent {
  id: number;
  category: string;
  name: string;
  price: number;
  details?: Record<string, string | number>;
}

// --- Custom Searchable Dropdown Component (Final Bulletproof Fix) ---
const SearchableDropdown = ({ category, items, selectedItem, onSelect }: any) => {
  const [isOpen, setIsOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const wrapperRef = useRef<HTMLDivElement>(null);

  // 1. Close dropdown if clicked outside
  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (wrapperRef.current && !wrapperRef.current.contains(event.target as Node)) {
        setIsOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  // 2. Safely handle typing without overwriting state
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearchTerm(e.target.value);
    setIsOpen(true);
    if (selectedItem) onSelect(null); // Unselect the item, but keep their typing
  };

  // 3. Handle selecting an item
  const handleSelectItem = (item: PCComponent) => {
    onSelect(item);
    setSearchTerm(item.name);
    setIsOpen(false);
  };

  // 4. Handle the "X" clear button
  const handleClear = () => {
    onSelect(null);
    setSearchTerm('');
    setIsOpen(true); // Instantly pop open the full list
  };

  // 5. Intelligent Filtering: If they haven't typed a new search yet, show ALL items.
  const showAll = selectedItem && searchTerm === selectedItem.name;
  const filteredItems = showAll 
    ? items 
    : items.filter((item: PCComponent) => 
        item.name.toLowerCase().includes(searchTerm.toLowerCase())
      );

  return (
    <div 
      className="searchable-dropdown" 
      ref={wrapperRef}
      style={{ zIndex: isOpen ? 100 : 1 }}
    >
      <label>{category}</label>
      <div className="input-wrapper">
        <input
          type="text"
          placeholder={`Search ${category}...`}
          value={searchTerm}
          onChange={handleInputChange}
          onFocus={(e) => {
            setIsOpen(true);
            e.target.select(); // Automatically highlights text so you can instantly re-type
          }}
        />
        {selectedItem && (
          <button className="clear-btn" onClick={handleClear}>✕</button>
        )}
      </div>
      
      {isOpen && (
        <ul className="suggestions-list">
          {filteredItems.length > 0 ? (
            filteredItems.map((item: PCComponent) => (
              <li 
                key={item.id} 
                onMouseDown={() => handleSelectItem(item)} // onMouseDown beats React focus bugs
              >
                <span className="item-name">{item.name}</span>
                <span className="item-price">₹{Number(item.price).toLocaleString('en-IN')}</span>
              </li>
            ))
          ) : (
            <li className="no-results">No {category} found</li>
          )}
        </ul>
      )}
    </div>
  );
};

// --- Main App Component ---
export default function App() {
  const [components, setComponents] = useState<PCComponent[]>([]);
  const [selectedParts, setSelectedParts] = useState<Record<string, PCComponent>>({});
  const [isDarkMode, setIsDarkMode] = useState(false);

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', isDarkMode ? 'dark' : 'light');
  }, [isDarkMode]);

  useEffect(() => {
    fetch('http://localhost:5000/api/components')
      .then((res) => res.json())
      .then((data) => setComponents(data))
      .catch((err) => console.error("Failed to fetch components:", err));
  }, []);

  const categories = Array.from(new Set(components.map(c => c.category)));
  
  const handleSelect = (category: string, item: PCComponent | null) => {
    setSelectedParts(prev => {
      const updated = { ...prev };
      if (item) updated[category] = item;
      else delete updated[category];
      return updated;
    });
  };

  const totalPrice = Object.values(selectedParts).reduce((sum, item) => sum + Number(item.price), 0);

  return (
    <div className="app-container">
      <header className="top-bar hide-on-print">
        <div className="logo">
          <h1>PCMaxing</h1>
          <p>Design your PC | Check compatibility of components | Real time updated prices</p>
        </div>
        <button 
          className="theme-toggle" 
          onClick={() => setIsDarkMode(!isDarkMode)}
        >
          {isDarkMode ? '☀️ Light Mode' : '🌙 Dark Mode'}
        </button>
      </header>
      
      <main className="builder-layout">
        <aside className="specs-panel hide-on-print">
          <h2>Detailed Specs</h2>
          {Object.keys(selectedParts).length === 0 ? (
            <div className="empty-state">Select parts to see their specifications.</div>
          ) : (
            <div className="specs-container">
              {Object.values(selectedParts).map(part => (
                <div key={part.id} className="spec-card">
                  <h4>{part.category}: {part.name}</h4>
                  {part.details ? (
                    <ul className="spec-list">
                      {Object.entries(part.details).map(([key, value]) => (
                        <li key={key}><strong>{key}:</strong> {value}</li>
                      ))}
                    </ul>
                  ) : (
                    <p className="no-specs">Detailed specs not available.</p>
                  )}
                </div>
              ))}
            </div>
          )}
        </aside>

        <div className="selectors hide-on-print">
          {categories.map(cat => (
            <SearchableDropdown
              key={cat}
              category={cat}
              items={components.filter(c => c.category === cat)}
              selectedItem={selectedParts[cat]}
              onSelect={(item: PCComponent | null) => handleSelect(cat, item)}
            />
          ))}
        </div>

        <aside className="invoice-section">
          <div className="invoice-header">
            <h2>Your Build</h2>
            <span className="part-count">{Object.keys(selectedParts).length} Parts</span>
          </div>
          
          {Object.keys(selectedParts).length === 0 ? (
            <div className="empty-state">Cart is empty.</div>
          ) : (
            <ul className="bill-items">
              {Object.values(selectedParts).map(part => (
                <li key={part.id}>
                  <div className="bill-item-details">
                    <span className="bill-cat">{part.category}</span>
                    <span className="bill-name">{part.name}</span>
                  </div>
                  <span className="bill-price">₹{Number(part.price).toLocaleString('en-IN')}</span>
                  {part.details && (
                    <div className="bill-item-specs">
                      {Object.entries(part.details).map(([key, value]) => (
                        <div key={key} className="spec-item">
                          <strong>{key}:</strong> {value}
                        </div>
                      ))}
                    </div>
                  )}
                </li>
              ))}
            </ul>
          )}
          
          <div className="total-row">
            <h3>Estimated Cost</h3>
            <h3 className="total-amount">₹{totalPrice.toLocaleString('en-IN')}</h3>
          </div>
          
          <button 
            onClick={() => window.print()} 
            className="print-btn hide-on-print" 
            disabled={Object.keys(selectedParts).length === 0}
          >
            Print
          </button>
        </aside>
      </main>
    </div>
  );
}